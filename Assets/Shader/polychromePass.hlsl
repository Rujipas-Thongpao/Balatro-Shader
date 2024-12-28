#ifndef CUSTOM_POLYCHROME_PASS
#define CUSTOM_POLYCHROME_PASS
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
float _Scale;
float _Opacity;


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
	// sample the texture
	float3 cols[7] = {
		float3(204, 102, 255),
		float3(102, 102, 255),
		float3(0, 153, 255),
		float3(102, 255, 153),
		float3(255, 255, 102),
		float3(255, 153, 102),
		float3(254, 51, 51)
	};

	fixed4 col = tex2D(_MainTex, input.uv);
	float3 viewDirection = normalize(_WorldSpaceCameraPos - input.positionWS);
	float3 fake_normal = input.normalWS + perlinNoise(input.uv);
	float d = abs(dot(viewDirection, fake_normal));

	d *= 7 * _Scale; 
	d %= 7;

	float lower = floor(d);
	float upper = ceil(d);

	float3 lowerCol = cols[lower%7]/255;
	float3 upperCol = cols[upper%7]/255;

	float4 polyCol = (0.,0.,0.,1.);
	polyCol.r = lerp(lowerCol.x, upperCol.x,frac(d) );
	polyCol.g = lerp(lowerCol.y, upperCol.y,frac(d) );
	polyCol.b = lerp(lowerCol.z, upperCol.z,frac(d) );

	if(distance(col, 1.)>=.8){
		col *= polyCol;
	}

	return col;
	

}

#endif
