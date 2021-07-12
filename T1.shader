Shader "Custom/Mask-Lit"
{
	Properties
	{
		[PerRendererData] _MainTex("Main Texture", 2D) = "white"{}	//主纹理

		[Header(PreRender Process)]//渲染前处理
		_CutOff("CutOff",Float) = 0.5//去除一部分透明区域
		_RenderAlpha("Render Alpha",range(0,1)) = 1//透明度
		_Bright("Bright", range(0,1)) = 1//亮度

		[Header(Texture Cover Settings)]//图片
		[MaterialToggle] _CoverEnabled("(Enabled)/(Disable)", Float) = 1
        _CoverTexture("Cover Texture", 2D) = "white" {}	//覆盖在原图上的纹理
        _CoverTextureAlpha("Cover Texture Alpha",range(0,1)) = 1//叠加贴图透明度
        

		[Header(Highlight Settings)]//高亮设置
		[MaterialToggle] _HighlightEnabled("(Enabled)/(Disable)",Float) = 1
		_HighlightColor("Highlight Color",Color) = (1,1,1,1)
		_HighlightAlpha("Highlight Alpha",range(0,1)) = 1

		[Header(Inline Edge Settings)]
		[MaterialToggle] _EdgeEnabled("(Enabled)/(Disable)",Float) = 1
		_EdgeColor("Edge Color", Color) = (0,0,0,1)
		_EdgeWidth("Edge Width",float) = 1//边缘厚度（表示程度）
		_EdgeAlpha("Edge Alpha",range(0,1)) = 1
	}

	SubShader
	{
		Tags
		{ 
			"Queue" = "Transparent" 
            "RenderType" = "Transparent" 
            "RenderPipeline" = "UniversalPipeline" //第三个标签不确定用途
			//"LightMode" = "Universal2D" 
		}
		Cull Off//双面材质
		Blend SrcAlpha OneMinusSrcAlpha//启用透明通道混合
		ZWrite Off
		
		HLSLINCLUDE
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Shaders/2D/Include/LightingUtility.hlsl"
			//4种不同的光照模型
			#pragma multi_compile USE_SHAPE_LIGHT_TYPE_0 __
			#pragma multi_compile USE_SHAPE_LIGHT_TYPE_1 __
			#pragma multi_compile USE_SHAPE_LIGHT_TYPE_2 __
			#pragma multi_compile USE_SHAPE_LIGHT_TYPE_3 __
			//这些参数会在CombinedShapeLightShared.hlsl中被宏定义判断来执行相应的光照处理方法
			#if USE_SHAPE_LIGHT_TYPE_0
			SHAPE_LIGHT(0)
			#endif

			#if USE_SHAPE_LIGHT_TYPE_1
			SHAPE_LIGHT(1)
			#endif

			#if USE_SHAPE_LIGHT_TYPE_2
			SHAPE_LIGHT(2)
			#endif

			#if USE_SHAPE_LIGHT_TYPE_3
			SHAPE_LIGHT(3)
			#endif

			//原材质参数
			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			half4 _MainTex_ST;
			half4 _MainTex_TexelSize;	//是个四元数，由着色器的_MainTex提供，Vector4(1 / width, 1 / height, width, height)
			//图片单句处理
			float _CutOff;
			float _RenderAlpha;
			float _Bright;
			//图片混合
			float _CoverEnabled;
			TEXTURE2D(_CoverTexture);
			SAMPLER(sampler_CoverTexture);
			float _CoverTextureAlpha;
			//调色覆盖
			float _HighlightEnabled;
			float4 _HighlightColor;
			float _HighlightAlpha;
			//内边缘
			float _EdgeEnabled;
			float4 _EdgeColor;
			float _EdgeWidth;
			float _EdgeAlpha;

			struct a2v//输入参数
			{
				float3 vertex   : POSITION;//位置坐标
				float4 color    : COLOR;//颜色信息
				float2 texcoord : TEXCOORD0;//纹理
			};

			struct v2f
			{
				float4 vertex		: SV_POSITION;//位置
				float4 color		: COLOR;
				float2 uv			: TEXCOORD0;//纹理坐标
				float2 lightingUV	: TEXCOORD1;
			};

			//图片混合方法体
			float4 CoverFunction(float4 mainTexColor,v2f i)
			{
				float4 finalColor = mainTexColor;
				//操作分支
				if(_CoverEnabled == 1)
				{
					finalColor.rgb = mainTexColor.rgb+SAMPLE_TEXTURE2D(_CoverTexture,sampler_CoverTexture,i.uv).rgb*_CoverTextureAlpha;
				}
				finalColor = finalColor*i.color; 
				return finalColor;
			}

			//图片高亮方法体
			float4 HighlightFunction(float4 mainTexColor,v2f i)
			{
				float4 finalColor = mainTexColor;
				if(_HighlightEnabled ==1)
				{
					finalColor +=(_HighlightColor-finalColor)*_HighlightAlpha;
					return finalColor;
				}
				return finalColor;
			}

			//图片内边缘方法体
			float4 InlineEdgeFunction(float4 mainTexColor,v2f i)
			{
				float4 finalColor = mainTexColor;
				if(_EdgeEnabled == 1)
				{
					_EdgeWidth = floor(_EdgeWidth);
					half alphaSum = 0;//计算纹理的透明度总值
					//8点计算法，复杂度O(1)
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(-_EdgeWidth, 0)).w;
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(_EdgeWidth, 0)).w;

					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(0, -_EdgeWidth)).w;
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(0, _EdgeWidth)).w;

					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(_EdgeWidth, -_EdgeWidth)).w;
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(_EdgeWidth, _EdgeWidth)).w;

					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(-_EdgeWidth, -_EdgeWidth)).w;
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(-_EdgeWidth, _EdgeWidth)).w;

					//内延伸
					float orignSum = mainTexColor.a*7.1;//7.1 = 8*8/9 公式为点数*点数/(点数+1)
					float isInColor = orignSum > alphaSum;//计算是否使用新纹理信息
					float4 deltaInlineColor = _EdgeColor-mainTexColor;
					finalColor = lerp(mainTexColor, mainTexColor+deltaInlineColor*_EdgeAlpha, isInColor);//选择使用原纹理或者选择使用边界纹理
					finalColor.a = mainTexColor.a;//保持原有的透明度
				}
				return finalColor;
			}

			//2D光照影响方法体(不知道为什么，HLSL的#include需要放在对应的方法前才能保证有效)
			#include "Packages/com.unity.render-pipelines.universal/Shaders/2D/Include/CombinedShapeLightShared.hlsl"
			float4 LightFunction(float4 mainTexColor,v2f i)
			{
				float4 finalColor = CombinedShapeLightShared(mainTexColor, float4(0,0,1,1), i.lightingUV);//将颜色信息与光照信息混合并返回，如果第二个参数有效则应当能看到"蓝色"（待测试）
				return finalColor;
			}
		ENDHLSL

		Pass
		{
			HLSLPROGRAM
			#pragma prefer_hlslcc gles//编译OpenGL ES 2的兼容性适配
			#pragma vertex vert//顶点着色器方法，主要处理平移，缩放等位置或者大小
			#pragma fragment frag//片段着色器方法，主要处理颜色
			
			v2f vert(a2v v)//a2v则指定了输入结构
			{
				v2f o;
				o.vertex = TransformObjectToHClip(v.vertex);//将位置转换为片段着色器的位置
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);//获取纹理坐标
                //总之这两步骤将模型的坐标转换为荧幕坐标，然后获取光照效果的坐标
                float4 clipVertex = o.vertex / o.vertex.w;
                o.lightingUV = ComputeScreenPos(clipVertex).xy;//获取光照效果的坐标
                o.color = v.color;

                return o;
			}

			float4 frag(v2f i) : SV_Target//使用SV_Target为i赋值，SV_Target是DX10+用于fragment函数着色器颜色输出的语义，相当于该方法是在原输出的基础上进行额外操作
			{
				float4 orign = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv)* i.color;//获取原目标点纹理信息（rgba）
				clip(orign.a - _CutOff);

				float4 finalColor = CoverFunction(orign,i);
				finalColor.rgb*=_Bright;//调整亮度
				finalColor = HighlightFunction(finalColor,i);
				finalColor = LightFunction(finalColor,i);
				finalColor = InlineEdgeFunction(finalColor,i);
				finalColor.a*=_RenderAlpha;
				return finalColor;//输出纹理
			}
			ENDHLSL
		}
	}
	Fallback "Sprites/Default"
}