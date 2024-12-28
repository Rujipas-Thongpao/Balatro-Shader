Shader "Unlit/CRT"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _CRTScale ("Scale", Range(0,30)) = 20
        _CRTOpacity ("Opacity", Range(0,1)) = .08 
        _RedCol ("Red Color", Color) = (1.,0.,0.,1.)
        _GreenCol ("Green Color", Color) = (0.,1.,0.,1.)
        _BlueCol ("Blue Color", Color) = (0.,0.,1.,1.)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Blend SrcAlpha One
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "./CRTPass.hlsl"
            ENDCG
        }
    }
}
