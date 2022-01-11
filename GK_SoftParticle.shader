/*
* Author：曹谦
* 这份文件主要是用来替代Shaders/lagecyShaders/additive
* 用于实现一定的粒子效果，并使得renderTexture能够捕获到像素
*/

Shader "Custom/MySoftParticle" {
	Properties{
		_MainTex("Particle Texture", 2d) = "white" {}
		_Brightness("亮度", Range(0,10)) = 1.0
		_ColorBlendAlpha("Color混合度",Range(0,1)) = 1
	}

	SubShader{

		Tags {
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"PreviewType" = "Plane"
		}
		Blend SrcAlpha One
		ColorMask RGBA
		Cull Off
		Lighting Off
		ZWrite off
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//#pragma multi_compile_particles//这个预编译指令好像是老的，所以后面的宏定义都不可以使用
			//Soft Particles require using Deferre Lighting or making camera render the depth texture

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D_float _CameraDepthTexture;
			fixed4 _TintColor;
			float _Brightness;
			float _ColorBlendAlpha;

			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
//#ifdef SOFTPARTICLES_ON
				float4 depth : TEXCOORD2;
//#endif
			};

			float4 AddColorToTex(float4 rawTex, float4 newTex, float theAlpha) {
				float4 result = float4((rawTex.rgb + (newTex.rgb - rawTex.rgb) * newTex.a * theAlpha), rawTex.a);
				return result;
			}

			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);

//#ifdef SOFTPARTICLES_ON
				//ComputeScreenPos传入裁剪空间顶点坐标变换到齐次坐标系下的坐标
				//齐次坐标就是将笛卡尔坐标转成矩阵，便于变换操作
				o.depth = ComputeScreenPos(o.vertex);
				//计算顶点摄像机空间的深度：距离裁剪平面的距离，线性变化；
				//在顶点着色器中取出深度信息储存到depth，在片段着色器中使用
				COMPUTE_EYEDEPTH(o.depth.z);
//#endif
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				//float4 rawTex = tex2D(_CameraDepthTexture, i.texcoord);//查看相机深度图
				float4 rawTex = tex2D(_MainTex, i.texcoord);//获取原始材质
				//float4 finTex = AddColorToTex(rawTex, _TintColor, 1);//材质静态颜色混合
				float4 finTex = AddColorToTex(rawTex, float4(i.color.rgb, 1), _ColorBlendAlpha);//材质动态颜色混合(需要unity提供的color参数)

				finTex.a *= i.color.a;
//#ifdef SOFTPARTICLES_ON
				float4 sceneZ = LinearEyeDepth(tex2Dproj(_CameraDepthTexture, i.depth));
				//float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.depth)));
				//float sceneZ = LinearEyeDepth(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.depth)).r);//和上面一句是等价的,但在较新的unity下会报错误
				float partZ = i.depth.z;
				float depthFade = saturate((sceneZ - partZ));//深度参数转化透明度
				finTex.a*= depthFade;
//#endif
				finTex.rgb *= finTex.a;//预乘
				finTex *= _Brightness;//亮度
				finTex.a = saturate(finTex.a);//钳制透明度
				return finTex;
			}
			ENDCG
		}
	}
}