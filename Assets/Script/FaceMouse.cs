using UnityEngine;

public class FaceMouse : MonoBehaviour
{
    [SerializeField] private float scale = 1.0f;
    void Update()
    {
        var v3 = Input.mousePosition;
        v3.z = 10.0f;
        v3 = Camera.main.ScreenToWorldPoint(v3);
        Vector2 dir = v3 - transform.position;
        transform.rotation = Quaternion.Euler(new Vector2(dir.y, -dir.x) * scale);
    }
}
