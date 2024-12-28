Shader "Unlit/Polychrome"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Scale ("Scale", Range(0,10)) = 1.
        _Opacity ("Opacity", Range(0,1)) = .5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Name "Polychrome Pass"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "./polychromePass.hlsl"

            ENDCG
        }
    }
}
