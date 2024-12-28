using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
public class PerObjectProperty : MonoBehaviour
{
    static int
        textureId = Shader.PropertyToID("_MainTex"),
        scaleId = Shader.PropertyToID("_Scale"),
        opacityId = Shader.PropertyToID("_Opacity");


    static MaterialPropertyBlock block;


    [SerializeField]
    Texture texture;

    [SerializeField, Range(0f, 10f)]
    float scale = 1f;

    [SerializeField, Range(0f, 1f)]
    float opacity = 1f;

    void Awake()
    {
        OnValidate();
    }

    void OnValidate()
    {
        if (block == null)
        {
            block = new MaterialPropertyBlock();
        }
        block.SetTexture(textureId, texture);
        block.SetFloat(scaleId, scale);
        block.SetFloat(opacityId, opacity);
        GetComponent<Renderer>().SetPropertyBlock(block);
    }
}
