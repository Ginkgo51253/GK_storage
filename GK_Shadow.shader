/*
* Author：曹谦
* 这份文件是用于实现无光投影材质
*/
Shader "Custom/MyShadow" {
	Properties{
		_MainTex("Texture", 2D) = "" {}
		_ShadowColor1("主阴影颜色",Color) = (0,0,0,1)
		_ShadowColor2("辅阴影颜色",Color) = (0,0,0,1)
		_PlaneAlpha("透明度",Range(0,1)) = 1
	}
	SubShader{
		Tags {
			"RenderType" = "Opaque" 
		}
		Blend One One
		ZWrite on

		Pass
		{
			Name "MainLight"
			Tags{
				"LightMode" = "ForwardBase"//主灯光(unity下显示为大太阳)
			}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "autolight.cginc"//SHADOW_COORDS需要这个包
			#pragma multi_compile_fwdbase
			#pragma multi_compile_fwdbase_fullshadows

			sampler2D _MainTex;
			float4 _MainTex_ST;

			float4 _ShadowColor1;
			float _PlaneAlpha;

			struct v2f {
				float4 pos:SV_POSITION;
				float2 texcoord:TEXCOORD3;
				SHADOW_COORDS(5)
			};

			v2f vert(appdata_full v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				TRANSFER_SHADOW(o)
				return o;
			}

			float4 frag(v2f i) :COLOR
			{
				float4 rawTex = tex2D(_MainTex, i.texcoord);//原始材质
				float4 finTex = rawTex;

				float shadow = SHADOW_ATTENUATION(i);//获取模型阴影状态
				float shadowAlpha = 1 - shadow;
				float4 shadowTex = fixed4(_ShadowColor1.rgb * shadow, 1);

				finTex.rgb = finTex.rgb * shadowTex.rgb;
				finTex.a = shadowAlpha * _PlaneAlpha;
				return finTex;
			}
			ENDCG
		}

		Pass
		{
			Name "SubLight"
			Tags{
				"LightMode" = "ForwardAdd"
			}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "autolight.cginc"//SHADOW_COORDS需要这个包
			#pragma multi_compile_fwdbase
			#pragma multi_compile_fwdbase_fullshadows

			sampler2D _MainTex;
			float4 _MainTex_ST;

			float4 _ShadowColor2;
			float _PlaneAlpha;

			struct v2f {
				float4 pos:SV_POSITION;
				float2 texcoord:TEXCOORD3;
				SHADOW_COORDS(5)
			};

			v2f vert(appdata_full v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				TRANSFER_SHADOW(o)
				return o;
			}

			float4 frag(v2f i) :COLOR
			{
				float4 rawTex = tex2D(_MainTex, i.texcoord);//原始材质
				float4 finTex = rawTex;

				float shadow = SHADOW_ATTENUATION(i);//获取模型阴影状态
				float shadowAlpha = 1 - shadow;
				float4 shadowTex = fixed4(_ShadowColor2.rgb * shadow, 1);

				finTex.rgb = finTex.rgb* shadowTex.rgb ;
				finTex.a = shadowAlpha * _PlaneAlpha;
				return finTex;
			}
			ENDCG
		}
	}
	FallBack "Specular"
}