using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEditor.VersionControl;
using UnityEngine;

/// <summary>
/// 平滑法线处理脚本
/// 将mesh拖入脚本对象或者将包含mesh的文件夹拖入地址框，执行结束后会将平滑的法线储存到tangent数组中
/// </summary>
public class GK_MeshSmoothNormals : EditorWindow
{
    private static List<Mesh> theMesh;
    private static int meshQuantity = 10;
    private static bool ChangedTint = false;
    private static string workingPath = "";

    [MenuItem("Tools/MeshSmoothNormal")]
    static void unityChaoJiChuTu_Start()
    {
        ScriptInit();
        MeshSmoothNormals window = (MeshSmoothNormals)GetWindowWithRect(typeof(MeshSmoothNormals), new Rect(10, 10, 160, 320), true, "MeshSmoothNormals");
        window.Show();
    }

    private void OnGUI()
    {
        if (!ChangedTint)//快捷刷新脚本窗口组件的方法，不然每次修改后都得重新打开窗口来加载静态对象
        {
            ScriptInit();
        }
        GUILayout.BeginArea(new Rect(5, 5, 150, 350));
        GUI.Label(new Rect(0, 0, 120, 20), "计算网格连续法线");
        for (int i = 1; i <= meshQuantity; i++)
        {
            if (theMesh.Count < i)
            {
                GUI.Label(new Rect(5, 25 * i, 20, 20), i.ToString());
                Mesh newMesh = (Mesh)EditorGUI.ObjectField(new Rect(25, 25 * i, 110, 20), null, typeof(Mesh), true);
                theMesh.Add(newMesh);
            }
            else
            {
                GUI.Label(new Rect(5, 25 * i, 20, 20), i.ToString());
                theMesh[i - 1] = (Mesh)EditorGUI.ObjectField(new Rect(25, 25 * i, 110, 20), theMesh[i - 1], typeof(Mesh), true);
            }
        }

        Rect workingPathArea = new Rect(5, 280, 80, 20);
        workingPath = GUI.TextField(workingPathArea, workingPath);
        if (workingPathArea.Contains(Event.current.mousePosition))
        {//可以使用鼠标位置判断进入指定区域
            DragAndDrop.visualMode = DragAndDropVisualMode.Generic;//改变鼠标外观
            if (Event.current.type == EventType.DragExited)
            {
                if (DragAndDrop.paths != null)
                {
                    int len = DragAndDrop.paths.Length;
                    string str = "";
                    for (int i = 0; i < len; i++)
                    {
                        str += DragAndDrop.paths[i];//输出拖入的文件或文件夹路径
                    }
                    workingPath = str;
                }
            }
        }
        if (GUI.Button(new Rect(90, 280, 50, 20), "批处理"))
        {
            ExecuteCalculation(theMesh);
            ExecuteCalculation(GetAllMeshInWorkingPath());
            Debug.LogWarning("MeshSmoothNormals:执行完成");
        }
        GUILayout.EndArea();
    }

    private static void ScriptInit()
    {
        theMesh = new List<Mesh>();
        meshQuantity = 10;
        ChangedTint = true;
        workingPath = "";
    }

    /// <summary>
    /// 执行入口
    /// </summary>
    /// <param name="meshs"></param>
    private static void ExecuteCalculation(IEnumerable<Mesh> meshs)
    {
        int count = 0;
        foreach (Mesh mesh in meshs)
        {
            if (mesh != null)
            {
                //mesh.normals = GenerateSmoothNormals(mesh);//这个是直接写入原法线，这样会影响原来的模型形状
                WriteNormalToTangent(mesh, GenerateSmoothNormals(mesh));//这个是写入到Tangent切线通道，取用切线通道不会影响模型形状
                count++;
            }
        }
        //Debug.LogWarning("MeshSmoothNormals:执行了 " + count + " 个对象");
    }

    /// <summary>
    /// 从指定路径获取所有目标资源（仅一级目录）
    /// Asset方法只能在Editor下使用
    /// </summary>
    /// <returns></returns>
    private static List<Mesh> GetAllMeshInWorkingPath()
    {
        List<Mesh> theseMeshes = new List<Mesh>();
        if (Directory.Exists(workingPath))
        {
            DirectoryInfo dInfo = new DirectoryInfo(workingPath);
            FileInfo[] fInfo = dInfo.GetFiles("*.mesh");
            foreach (FileInfo files in fInfo)
            {
                if (files.Name.EndsWith(".meta"))
                {
                    continue;
                }
                else
                {
                    Asset thisMesh = new Asset(files.FullName);
                    theseMeshes.Add((Mesh)thisMesh.Load());
                }
            }
        }
        else
        {
            //Debug.LogWarning("MeshSmoothNormals:指定工作路径不存在");
        }
        return theseMeshes;
    }

    /// <summary>
    /// 生成平滑法线的方法
    /// </summary>
    /// <param name="_srcMesh"></param>
    /// <returns></returns>
    private static Vector3[] GenerateSmoothNormals(Mesh _srcMesh)
    {
        Vector3[] verticies = _srcMesh.vertices;//获取网格顶点
        Vector3[] normals = _srcMesh.normals;//获取原法线
        Vector3[] smoothNormals = new Vector3[normals.Length];
        normals.CopyTo(smoothNormals, 0);//进行一次法线拷贝，最好是深拷贝
        var groups = verticies.Select((vertex, index) => new KeyValuePair<Vector3, int>(vertex, index)).GroupBy(pair => pair.Key);
        //先将法线按顶点位置分组，一个点可以拥有多个法线，并且这个点在网格上具有唯一的标识
        //然后对同组中的法线做平均值处理，对于法向量来说就是相加然后直接标准化
        //然后替换经过修改的法线
        foreach (var group in groups)
        {
            if (group.Count() == 1)
                continue;
            Vector3 smoothNormal = Vector3.zero;
            foreach (var index in group)
                smoothNormal += normals[index.Value];
            smoothNormal = smoothNormal.normalized;
            foreach (var index in group)
                smoothNormals[index.Value] = smoothNormal;
        }
        return smoothNormals;
    }

    /// <summary>
    /// 将法线写入到网格的Tangent通道中
    /// </summary>
    private static void WriteNormalToTangent(Mesh theMesh, Vector3[] theNormals)
    {
        Vector4[] xyzw = new Vector4[theNormals.Length];
        for (int i = 0; i < theNormals.Length; i++)
        {
            xyzw[i] = new Vector4(theNormals[i].x, theNormals[i].y, theNormals[i].z, 1);
        }
        theMesh.tangents = xyzw;
    }
}
