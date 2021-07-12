Shader "Custom/Mask-Lit"
{
	Properties
	{
		[PerRendererData] _MainTex("Main Texture", 2D) = "white"{}	//������

		[Header(PreRender Process)]//��Ⱦǰ����
		_CutOff("CutOff",Float) = 0.5//ȥ��һ����͸������
		_RenderAlpha("Render Alpha",range(0,1)) = 1//͸����
		_Bright("Bright", range(0,1)) = 1//����

		[Header(Texture Cover Settings)]//ͼƬ
		[MaterialToggle] _CoverEnabled("(Enabled)/(Disable)", Float) = 1
        _CoverTexture("Cover Texture", 2D) = "white" {}	//������ԭͼ�ϵ�����
        _CoverTextureAlpha("Cover Texture Alpha",range(0,1)) = 1//������ͼ͸����
        

		[Header(Highlight Settings)]//��������
		[MaterialToggle] _HighlightEnabled("(Enabled)/(Disable)",Float) = 1
		_HighlightColor("Highlight Color",Color) = (1,1,1,1)
		_HighlightAlpha("Highlight Alpha",range(0,1)) = 1

		[Header(Inline Edge Settings)]
		[MaterialToggle] _EdgeEnabled("(Enabled)/(Disable)",Float) = 1
		_EdgeColor("Edge Color", Color) = (0,0,0,1)
		_EdgeWidth("Edge Width",float) = 1//��Ե��ȣ���ʾ�̶ȣ�
		_EdgeAlpha("Edge Alpha",range(0,1)) = 1
	}

	SubShader
	{
		Tags
		{ 
			"Queue" = "Transparent" 
            "RenderType" = "Transparent" 
            "RenderPipeline" = "UniversalPipeline" //��������ǩ��ȷ����;
			//"LightMode" = "Universal2D" 
		}
		Cull Off//˫�����
		Blend SrcAlpha OneMinusSrcAlpha//����͸��ͨ�����
		ZWrite Off
		
		HLSLINCLUDE
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Shaders/2D/Include/LightingUtility.hlsl"
			//4�ֲ�ͬ�Ĺ���ģ��
			#pragma multi_compile USE_SHAPE_LIGHT_TYPE_0 __
			#pragma multi_compile USE_SHAPE_LIGHT_TYPE_1 __
			#pragma multi_compile USE_SHAPE_LIGHT_TYPE_2 __
			#pragma multi_compile USE_SHAPE_LIGHT_TYPE_3 __
			//��Щ��������CombinedShapeLightShared.hlsl�б��궨���ж���ִ����Ӧ�Ĺ��մ�����
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

			//ԭ���ʲ���
			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			half4 _MainTex_ST;
			half4 _MainTex_TexelSize;	//�Ǹ���Ԫ��������ɫ����_MainTex�ṩ��Vector4(1 / width, 1 / height, width, height)
			//ͼƬ���䴦��
			float _CutOff;
			float _RenderAlpha;
			float _Bright;
			//ͼƬ���
			float _CoverEnabled;
			TEXTURE2D(_CoverTexture);
			SAMPLER(sampler_CoverTexture);
			float _CoverTextureAlpha;
			//��ɫ����
			float _HighlightEnabled;
			float4 _HighlightColor;
			float _HighlightAlpha;
			//�ڱ�Ե
			float _EdgeEnabled;
			float4 _EdgeColor;
			float _EdgeWidth;
			float _EdgeAlpha;

			struct a2v//�������
			{
				float3 vertex   : POSITION;//λ������
				float4 color    : COLOR;//��ɫ��Ϣ
				float2 texcoord : TEXCOORD0;//����
			};

			struct v2f
			{
				float4 vertex		: SV_POSITION;//λ��
				float4 color		: COLOR;
				float2 uv			: TEXCOORD0;//��������
				float2 lightingUV	: TEXCOORD1;
			};

			//ͼƬ��Ϸ�����
			float4 CoverFunction(float4 mainTexColor,v2f i)
			{
				float4 finalColor = mainTexColor;
				//������֧
				if(_CoverEnabled == 1)
				{
					finalColor.rgb = mainTexColor.rgb+SAMPLE_TEXTURE2D(_CoverTexture,sampler_CoverTexture,i.uv).rgb*_CoverTextureAlpha;
				}
				finalColor = finalColor*i.color; 
				return finalColor;
			}

			//ͼƬ����������
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

			//ͼƬ�ڱ�Ե������
			float4 InlineEdgeFunction(float4 mainTexColor,v2f i)
			{
				float4 finalColor = mainTexColor;
				if(_EdgeEnabled == 1)
				{
					_EdgeWidth = floor(_EdgeWidth);
					half alphaSum = 0;//���������͸������ֵ
					//8����㷨�����Ӷ�O(1)
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(-_EdgeWidth, 0)).w;
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(_EdgeWidth, 0)).w;

					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(0, -_EdgeWidth)).w;
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(0, _EdgeWidth)).w;

					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(_EdgeWidth, -_EdgeWidth)).w;
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(_EdgeWidth, _EdgeWidth)).w;

					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(-_EdgeWidth, -_EdgeWidth)).w;
					alphaSum+=SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv + _MainTex_TexelSize.xy * half2(-_EdgeWidth, _EdgeWidth)).w;

					//������
					float orignSum = mainTexColor.a*7.1;//7.1 = 8*8/9 ��ʽΪ����*����/(����+1)
					float isInColor = orignSum > alphaSum;//�����Ƿ�ʹ����������Ϣ
					float4 deltaInlineColor = _EdgeColor-mainTexColor;
					finalColor = lerp(mainTexColor, mainTexColor+deltaInlineColor*_EdgeAlpha, isInColor);//ѡ��ʹ��ԭ�������ѡ��ʹ�ñ߽�����
					finalColor.a = mainTexColor.a;//����ԭ�е�͸����
				}
				return finalColor;
			}

			//2D����Ӱ�췽����(��֪��Ϊʲô��HLSL��#include��Ҫ���ڶ�Ӧ�ķ���ǰ���ܱ�֤��Ч)
			#include "Packages/com.unity.render-pipelines.universal/Shaders/2D/Include/CombinedShapeLightShared.hlsl"
			float4 LightFunction(float4 mainTexColor,v2f i)
			{
				float4 finalColor = CombinedShapeLightShared(mainTexColor, float4(0,0,1,1), i.lightingUV);//����ɫ��Ϣ�������Ϣ��ϲ����أ�����ڶ���������Ч��Ӧ���ܿ���"��ɫ"�������ԣ�
				return finalColor;
			}
		ENDHLSL

		Pass
		{
			HLSLPROGRAM
			#pragma prefer_hlslcc gles//����OpenGL ES 2�ļ���������
			#pragma vertex vert//������ɫ����������Ҫ����ƽ�ƣ����ŵ�λ�û��ߴ�С
			#pragma fragment frag//Ƭ����ɫ����������Ҫ������ɫ
			
			v2f vert(a2v v)//a2v��ָ��������ṹ
			{
				v2f o;
				o.vertex = TransformObjectToHClip(v.vertex);//��λ��ת��ΪƬ����ɫ����λ��
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);//��ȡ��������
                //��֮�������轫ģ�͵�����ת��ΪӫĻ���꣬Ȼ���ȡ����Ч��������
                float4 clipVertex = o.vertex / o.vertex.w;
                o.lightingUV = ComputeScreenPos(clipVertex).xy;//��ȡ����Ч��������
                o.color = v.color;

                return o;
			}

			float4 frag(v2f i) : SV_Target//ʹ��SV_TargetΪi��ֵ��SV_Target��DX10+����fragment������ɫ����ɫ��������壬�൱�ڸ÷�������ԭ����Ļ����Ͻ��ж������
			{
				float4 orign = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv)* i.color;//��ȡԭĿ���������Ϣ��rgba��
				clip(orign.a - _CutOff);

				float4 finalColor = CoverFunction(orign,i);
				finalColor.rgb*=_Bright;//��������
				finalColor = HighlightFunction(finalColor,i);
				finalColor = LightFunction(finalColor,i);
				finalColor = InlineEdgeFunction(finalColor,i);
				finalColor.a*=_RenderAlpha;
				return finalColor;//�������
			}
			ENDHLSL
		}
	}
	Fallback "Sprites/Default"
}