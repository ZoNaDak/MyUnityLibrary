Shader "Custom/MovedHighLight"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _HighlightTex ("Highlight Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Option ("Size&Speed", vector) = (1,1,1,1)
        _Power ("Power", float) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard alpha:fade

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _HighlightTex;

        fixed4 _Color;
        fixed4 _Option;
        float _Power;

        struct Input {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o) {
            fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x, IN.uv_MainTex.y));
            fixed4 h = tex2D (_HighlightTex, float2((IN.uv_MainTex.x + _Time.y * _Option.z) * _Option.x, (IN.uv_MainTex.y + _Time.y * _Option.w) * _Option.y));
            o.Emission = c.rgb + h.rgb * _Color.rgb * _Power;
            o.Alpha = c.a;
        }
        ENDCG
    }
}