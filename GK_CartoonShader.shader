/*
* Author：曹谦
* 这份文件是用于实现卡通渲染的，需要挂载在待渲染的模型上
*/
Shader "Custom/MyCartoonShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "" {}
		[Header(BaseColor)]
		_MainDye("基础材质染色",Color)=(1,1,1,0)
		
		[Header(Outline)]
		_OutlineColor("外描边颜色", Color) = (0,0,0,1)
		_OutlineWidth("外描边宽度", Range(0, 0.05)) = 0

		[Header(Inline)]
		_InlineColor("内描边渐变颜色", Color) = (0,0,0,1)
		_InlineSoft("内描边渐变缓度",Range(-1,4)) = 0

		[Header(SurfaceHighlight)]
		_SpotColor("表面高光颜色",Color)=(1,1,1,1)
		_SpotSoft("表面高光渐变缓度",Range(-1,100)) = 0

		[Header(Shadow)]
		_ShadowColorMain("主阴影颜色",Color)=(1,1,1,0)
		_ShadowColorSub("辅阴影颜色",Color)=(0,0,0,0)
		
		[Header(CartoonLine)]
		[MaterialToggle] _CartoonLineEnabled("(启用)/(不启用)",Float) = 1
		_Bands("卡通线细分系数",Float) = 2
		_BandSoft("卡通线细分缓度",Range(0,5)) = 1
	}
	SubShader
	{
		Tags {
			"RenderType" = "Opaque"
		}
		Blend One OneMinusSrcAlpha//启用透明通道混合
		ZWrite on

		//3D模型外描边
		Pass{
			Name "Outline"
			Tags{
			}
			Cull Front

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			uniform float _OutlineWidth;
			uniform float4 _OutlineColor;

			struct VertexInput {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord:TEXCOORD0;
				//float4 color : COLOR;
			};

			struct VertexOutput {
				float4 pos : SV_POSITION;
				float2 texcoord:TEXCOORD0;
				//float4 color : COLOR;
			};

			float4 AddColorToTex(float4 rawTex, float4 newTex, float theAlpha) {
				float4 result = float4((rawTex.rgb + (newTex.rgb - rawTex.rgb) * newTex.a * theAlpha), rawTex.a);
				return result;
			}

			VertexOutput vert(VertexInput v) {
				VertexOutput o = (VertexOutput)0;
				o.pos = UnityObjectToClipPos(float4(v.vertex.xyz + v.normal*_OutlineWidth,1));//简单的描边外扩
				o.texcoord = v.texcoord;//TRANSFORM_TEX(v.texcoord,_MainTex);
				return o;
			}

			float4 frag(VertexOutput i) : COLOR{
				float4 rawTex = tex2D(_MainTex, i.texcoord);//原始材质
				float4 finTex = AddColorToTex(rawTex, _OutlineColor, 1);
				return finTex;//fixed4(_OutlineColor.rgb,1);
			}
			ENDCG
		}

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
			#include "lighting.cginc"//_LightColor0需要这个包
			#include "autolight.cginc"//SHADOW_COORDS需要这个包
			#pragma multi_compile_fwdbase
			#pragma multi_compile_fwdbase_fullshadows

			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed4 _MainDye;
			fixed4 _InlineColor;
			float _InlineSoft;
			fixed4 _SpotColor;
			float _SpotSoft;
			float4 _MirrorReflectionColor;
			float4 _ShadowColorMain;
			float _CartoonLineEnabled;
			float _Bands;
			float _BandSoft;

			struct v2f {
				float4 pos:SV_POSITION;
				float3 lightDir:TEXCOORD0;
				float3 viewDir:TEXCOORD1;
				float3 normal:TEXCOORD2;
				float2 texcoord:TEXCOORD3;
				float4 vertex:TEXCOORD4;
				SHADOW_COORDS(5)
			};

			v2f vert(appdata_full v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.normal = v.normal;
				o.lightDir = ObjSpaceLightDir(v.vertex);
				o.viewDir = ObjSpaceViewDir(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.vertex = v.vertex;
				TRANSFER_SHADOW(o)
				return o;
			}

			float CurveFn(float a,float x) {//曲线修正函数，可以用其他f(0)=0且f(1)=1的函数替换
				return pow(x,a);
			}

			float4 AddColorToTex(float4 rawTex,float4 newTex,float theAlpha) {
				float4 result = float4((rawTex.rgb + (newTex.rgb - rawTex.rgb) * newTex.a * theAlpha), rawTex.a);
				return result;
			}

			float4 frag(v2f i) :COLOR
			{
				float4 rawTex = tex2D(_MainTex, i.texcoord);//原始材质
				float4 finTex = rawTex;

				finTex.rgb = _MainDye.rgb * _MainDye.a + finTex.rgb;

				float3 normal = normalize(i.normal);//法向量（标准化）
				float3 viewDir = normalize(i.viewDir);//视角向量（标准化）
				float3 lightDir = normalize(i.lightDir);//灯光向量（标准化）
				
				float edgeAlpha = 1- abs(dot(normal, viewDir));//获取模型内边缘
				float4 edgeTex = fixed4(_InlineColor.rgb, edgeAlpha* CurveFn(_InlineSoft,edgeAlpha));//内边缘发光着色
				finTex = AddColorToTex(finTex, edgeTex, _InlineColor.a);

				float spotAlpha = abs(dot(normal, viewDir));//获取模型正表面
				float4 spotTex = fixed4(_SpotColor.rgb, spotAlpha * CurveFn(_SpotSoft, spotAlpha));//表面高光
				finTex = AddColorToTex(finTex, spotTex, _SpotColor.a);
				
				float lightAlpha = 0.5 * (1 + dot(lightDir, normal));//获取模型受光状态
				float4 lightTex = fixed4(_LightColor0.rgb * lightAlpha, 1);

				float shadow = SHADOW_ATTENUATION(i);//获取模型阴影状态
				float4 shadowTex = fixed4(_ShadowColorMain.rgb* shadow,1);

				float cartoonFloor = lerp(floor(CurveFn(_BandSoft, max(0, dot(lightDir, normal))) * _Bands) / (_Bands - 1), 1, 1-_CartoonLineEnabled);//卡通线非连续颜色
				/*
				//上面一句等同与下方的控制流
				float cartoonFloor = 1;
				if (_CartoonLineEnabled == 1) {
					float bands = CurveFn(_BandSoft, max(0, dot(lightDir, normal))) * _Bands;
					cartoonFloor = floor(bands) / (_Bands - 1);
				}
				*/
				return shadowTex * lightTex * finTex * cartoonFloor;
			}
			ENDCG
		}
		
		Pass
		{
			Name "SubLight"
			Tags{
				"LightMode" = "ForwardAdd"//其他灯光(unity下显示为小太阳)
			}
			Blend One One

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "lighting.cginc"
			#include "autolight.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed4 _MainDye;
			fixed4 _InlineColor;
			float _InlineSoft;
			fixed4 _SpotColor;
			float _SpotSoft;
			float4 _MirrorReflectionColor;
			float4 _ShadowColorSub;
			float _CartoonLineEnabled;
			float _Bands;
			float _BandSoft;

			struct v2f {
				float4 pos:SV_POSITION;
				float3 lightDir:TEXCOORD0;
				float3 viewDir:TEXCOORD1;
				float3 normal:TEXCOORD2;
				float2 texcoord:TEXCOORD3;
				float4 vertex:TEXCOORD4;
				SHADOW_COORDS(5)
			};

			v2f vert(appdata_full v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.normal = v.normal;
				o.lightDir = ObjSpaceLightDir(v.vertex);
				o.viewDir = ObjSpaceViewDir(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.vertex = v.vertex;
				TRANSFER_SHADOW(o)
				return o;
			}

			float CurveFn(float a,float x) {
				return pow(x,a);
			}

			float4 AddColorToTex(float4 rawTex,float4 newTex,float theAlpha) {
				float4 result = float4((rawTex.rgb + (newTex.rgb - rawTex.rgb) * newTex.a * theAlpha), rawTex.a);
				return result;
			}

			float4 frag(v2f i) :COLOR
			{

				float4 rawTex = tex2D(_MainTex, i.texcoord);//原始材质
				float4 finTex = rawTex;

				finTex.rgb = _MainDye.rgb * _MainDye.a  + finTex.rgb;

				float3 normal = normalize(i.normal);//法向量（标准化）
				float3 viewDir = normalize(i.viewDir);//视角向量（标准化）
				float3 lightDir = normalize(i.lightDir);//灯光向量（标准化）
				
				float edgeAlpha = 1- abs(dot(normal, viewDir));//获取模型内边缘
				float4 edgeTex = fixed4(_InlineColor.rgb, edgeAlpha* CurveFn(_InlineSoft,edgeAlpha));//内边缘发光着色
				finTex = AddColorToTex(finTex, edgeTex, _InlineColor.a);

				float spotAlpha = abs(dot(normal, viewDir));//获取模型正表面
				float4 spotTex = fixed4(_SpotColor.rgb, spotAlpha * CurveFn(_SpotSoft, spotAlpha));//表面高光
				finTex = AddColorToTex(finTex, spotTex, _SpotColor.a);
				
				float lightAlpha =0.5*(1+ dot(lightDir, normal));//获取模型受光状态
				float4 lightTex = fixed4(_LightColor0.rgb* lightAlpha, 1);

				float shadow = SHADOW_ATTENUATION(i);//获取模型阴影状态
				float4 shadowTex = fixed4(_ShadowColorSub.rgb* shadow, 1);

				float cartoonFloor = lerp(floor(CurveFn(_BandSoft, max(0, dot(lightDir, normal))) * _Bands) / (_Bands - 1), 1, 1-_CartoonLineEnabled);//卡通线非连续颜色

				return shadowTex * lightTex * finTex * cartoonFloor;
			}  
			ENDCG
		}
	}
	FallBack "Specular"
}