Shader "Custom/god ray 2 blend"
{
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "" {}
		_GodRayTex ("God (RGB)", 2D) = ""{}
		_Alpha("_Alpha", Float) = 0.5
	}
	
	CGINCLUDE
	
	#include "UnityCG.cginc"

	struct v2in
	{
		float4 vertex : POSITION;
		float2 texcoord : TEXCOORD0;
	};

	struct v2f
	{
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	};

	sampler2D _MainTex;
	sampler2D _GodRayTex;
	uniform float _Alpha;

	v2f vert(v2in v)
	{
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		o.uv = v.texcoord;
		return o;
	}

	half4 frag(v2f i) : COLOR
	{
		half4 color = tex2D(_MainTex, i.uv) + tex2D(_GodRayTex, i.uv)*_Alpha;
		return color;
	}

	ENDCG

	Subshader
	{
		Tags{ "Queue" = "Transparent" }

		Pass
		{
			ZWrite Off

			// °ó¶¨Í¨µÀ
			BindChannels
			{
				Bind "Vertex", vertex
				Bind "texcoord", texcoord0
				Bind "texcoord1", texcoord1
			}

			Fog{ Mode off }

			CGPROGRAM
			#pragma fragmentoption ARB_precision_hint_fastest 
			#pragma vertex vert
			#pragma fragment frag
			ENDCG
		}
	}

	Fallback off
}