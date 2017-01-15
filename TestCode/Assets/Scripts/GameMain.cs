using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class GameMain : MonoBehaviour
{
    public GameObject cube1;
    public GameObject cube2;

    public bool open1;
    public bool open2;

    private List<Cube1> m_cubeList1;
    private List<Cube2> m_cubeList2;

    // Use this for initialization
    void Start()
    {
        System.Diagnostics.Stopwatch stopwatch = new System.Diagnostics.Stopwatch();
        stopwatch.Start();

        if (open1 && cube1 != null)
        {
            m_cubeList1 = new List<Cube1>();

            for (int i = 0; i < 10000; ++i)
            {
                GameObject go = (GameObject)GameObject.Instantiate(cube1);
                go.transform.parent = transform;

                Cube1 temp = go.GetComponent<Cube1>();
                m_cubeList1.Add(temp);
            }
        }

        if (open2 && cube2 != null)
        {
            m_cubeList2 = new List<Cube2>();

            for (int i = 0; i < 10000; ++i)
            {
                GameObject go = (GameObject)GameObject.Instantiate(cube2);
                go.transform.parent = transform;

                Cube2 temp = new Cube2(go);
                m_cubeList2.Add(temp);
            }
        }

        stopwatch.Stop();
        System.TimeSpan timeSpan = stopwatch.Elapsed;

        Debug.Log("加载用时 = " + timeSpan.TotalSeconds);
    }
}
