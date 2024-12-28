
#ifndef CUSTOM_CRT_PASS
#define CUSTOM_CRT_PASS

struct appdata
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float2 uv : TEXCOORD0;
};

struct v2f
{
	float2 uv : TEXCOORD0;
	float3 normalWS : VAR_NORMAL;
	float3 positionWS : VAR_POSITION;
	float4 vertex : SV_POSITION;
};

sampler2D _MainTex;
float4 _MainTex_ST;
float4 _RedCol;
float4 _GreenCol;
float4 _BlueCol;
float _CRTScale;
float _CRTOpacity;

#include "UnityCG.cginc"
#include "./noise.hlsl"


v2f vert (appdata v)
{
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);
	o.normalWS = UnityObjectToWorldNormal(v.normal);
	o.positionWS = mul(unity_ObjectToWorld, v.vertex);
	return o;
}

float4 frag (v2f input) : SV_Target
{

	float4 cols[3] = {
		_RedCol,
		_GreenCol,
		_BlueCol
	};
	float ny = input.uv.y * 3 * _CRTScale% 3;
	float lower = floor(ny);
	float upper = ceil(ny);

	float4 lowerCol = cols[lower%3];
	float4 upperCol = cols[upper%3];

	float4 crtCol = (0.,0.,0.,1.);
	crtCol.r = lerp(lowerCol.x, upperCol.x,frac(ny) );
	crtCol.g = lerp(lowerCol.y, upperCol.y,frac(ny) );
	crtCol.b = lerp(lowerCol.z, upperCol.z,frac(ny) );
	crtCol.a = _CRTOpacity;

	return crtCol;
}

#endif
