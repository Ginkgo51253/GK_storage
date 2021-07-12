Shader "Custom/UIScroll"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}// 纹理
        _ScrollX("Horizontal Scroll Speed",Float) = 1.0// 水平滚动速度
        _ScrollY("Vertical Scroll Speed",Float) = 1.0// 垂直滚动速度
        _Mutiplier("Light Mutiplier", Float) = 1//整体亮度
    }
    SubShader
    {
        Tags{ "RenderType" = "Transparent" "Queue" = "Geometry" }
        LOD 100

        Pass
        {
            //Tags{ "LightMode" = "ForwardBase" }
            CGPROGRAM

                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"

                struct a2v
                {
                    float4 vertex : POSITION;
                    float2 texcoord : TEXCOORD0;
                };

                struct v2f
                {
                    float4 pos : SV_POSITION;
                    float2 uv : TEXCOORD0;
                };

                sampler2D _MainTex;
                float4 _MainTex_ST;
                float _ScrollX;
                float _ScrollY;
                float _Mutiplier;

                v2f vert(a2v v)
                {
                    v2f o;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex) + frac(float2 (_ScrollX, _ScrollY) * _Time.y * 100);
                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    fixed4 c = tex2D(_MainTex, i.uv.xy);
                    clip(c.a - 0.8);
                    c.rgb *= _Mutiplier;
                    return c;
                }

            ENDCG
        }
    }
    FallBack "VertexLit"
}