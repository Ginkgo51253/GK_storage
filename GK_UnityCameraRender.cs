using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GK_UnityCameraRender
{
    public static readonly int[] width = { 2560, 256, 5120 };//图片长度
    public static readonly int[] height = { 1920, 192, 3840 };//图片宽度
    public static readonly TextureFormat textureFormat = TextureFormat.ARGB32;//24位rgb带alpha通道，即argb32

    private Texture2D thisTex;
    private RenderTexture renderTexture;
    private CameraRenderChoice cameraRenderChoice;

    /// <summary>
    /// 可选的使用较小的图片进行渲染
    /// </summary>
    /// <param name="cameraRenderChoice"></param>
    public UnityCameraRender(CameraRenderChoice cameraRenderChoice = CameraRenderChoice.default_2560x1920)
    {
        this.cameraRenderChoice = cameraRenderChoice;
        renderTexture = new RenderTexture(width[(int)cameraRenderChoice], height[(int)cameraRenderChoice], 0);//创建一个RenderTexture对象,即创建画布
        //renderTexture.antiAliasing = 16;//Unity自己的抗锯齿，但看不出效果
        thisTex = new Texture2D(width[(int)cameraRenderChoice], height[(int)cameraRenderChoice], TextureFormat.ARGB32, false);//创建一个Texture2对象，用于保存Render Texture信息
    }

    ~UnityCameraRender()
    {
        Object.Destroy(thisTex);
        Object.Destroy(renderTexture);
    }

    public Texture2D GetViewData(Camera cCamera)
    {
        Texture2D tex = CameraCapture(cCamera, (int)cameraRenderChoice);
        tex = SimpleInverseAlphaBlend(tex);//预乘还原
        //tex = SimpleAntiAliasing0(tex, width[(int)cameraRenderChoice], height[(int)cameraRenderChoice]);//简易抗锯齿
        tex = SimpleAntiAliasing1(tex, width[(int)cameraRenderChoice], height[(int)cameraRenderChoice]);//带权平滑抗锯齿
        tex.Apply();//保存材质
        return tex;
    }

    /// <summary>
    /// 捕获相机视图
    /// Unity下调用视口不能在子线程中使用
    /// </summary>
    /// <param name="viewCamera"></param>
    /// <param name="choice"></param>
    /// <returns></returns>
    private Texture2D CameraCapture(Camera viewCamera, int choice)
    {
        viewCamera.gameObject.SetActive(true);//启用截图相机
        viewCamera.targetTexture = renderTexture;//将相机的渲染结果输出到指定画布上
        viewCamera.Render();//手动开启相机渲染
        RenderTexture.active = renderTexture;//设置当前激活的RenderTexture的捕获对象为指定画布
        thisTex.ReadPixels(new Rect(0, 0, width[choice], height[choice]), 0, 0);//从当前激活的视口读取像素
        viewCamera.targetTexture = null;//重置截图相机的targetTexture
        RenderTexture.active = null;//关闭RenderTexture的激活状态
        return thisTex;
    }

    /// <summary>
    /// unity相机透明色混合还原算法
    /// 相机的背景颜色需要首先置为黑色透明（不是唯一解，但计算最方便）
    /// </summary>
    /// <param name="tex"></param>
    /// <returns></returns>
    private Texture2D SimpleInverseAlphaBlend(Texture2D tex)
    {
        //新方法 渲染单图不到100毫秒
        byte[] bytes = tex.GetRawTextureData();//2毫秒
        for (int i = 0; i < bytes.Length / 4; i++)//循环单句大约15毫秒 bytes.length = 2560*1920*4
        {
            if (bytes[i * 4] == 0)//a
            {
                continue;
            }
            //这三句大约30毫秒
            int r = bytes[i * 4 + 1] * 255 / bytes[i * 4];
            int g = bytes[i * 4 + 2] * 255 / bytes[i * 4];
            int b = bytes[i * 4 + 3] * 255 / bytes[i * 4];
            if (r > 255)
            {
                r = 255;
            }
            if (g > 255)
            {
                g = 255;
            }
            if (b > 255)
            {
                b = 255;
            }
            bytes[i * 4 + 1] = (byte)r;//r
            bytes[i * 4 + 2] = (byte)g;//g
            bytes[i * 4 + 3] = (byte)b;//b
        }
        tex.LoadRawTextureData(bytes);//3-8毫秒
        /*
        //老方法 单图大约1800毫秒
        for (int y = 0; y < tex.height; y++)
        {
            for (int x = 0; x < tex.width; x++)
            {

                Color pixColor = tex.GetPixel(x, y);//循环中用时大约0.9秒
                Debug.Log(pixColor.r + " " + pixColor.g + " " + pixColor.b + " " + pixColor.a);
                pixColor.r /= pixColor.a;
                pixColor.g /= pixColor.a;
                pixColor.b /= pixColor.a;
                tex.SetPixel(x, y, pixColor);//循环中用时大约0.9秒
            }
        }
        */
        return tex;
    }


    /// <summary>
    /// 只针对图片边缘进行的简易抗锯齿
    /// </summary>
    /// <param name="tex"></param>
    /// <returns></returns>
    private Texture2D SimpleAntiAliasing0(Texture2D tex, int width, int height)
    {
        byte[] bytes = tex.GetRawTextureData();
        if (width * height * 4 != bytes.Length)
        {
            return tex;
        }
        byte[] tbytes = new byte[bytes.Length];
        for (int i = 1; i < height - 1; i++)
        {
            for (int j = 1; j < width - 1; j++)
            {
                if (bytes[i * width * 4 + (j) * 4] == 0 && (bytes[i * width * 4 + (j - 1) * 4] != 0 || bytes[i * width * 4 + (j + 1) * 4] != 0 || bytes[(i - 1) * width * 4 + j * 4] != 0 || bytes[(i + 1) * width * 4 + j * 4] != 0))
                {
                    for (int k = 0; k < 4; k++)
                    {
                        tbytes[i * width * 4 + j * 4 + k] =
                            (byte)
                            (
                                (
                                    bytes[i * width * 4 + (j) * 4 + k] +
                                    bytes[i * width * 4 + (j - 1) * 4 + k] +
                                    bytes[i * width * 4 + (j + 1) * 4 + k] +
                                    bytes[(i - 1) * width * 4 + j * 4 + k] +
                                    bytes[(i + 1) * width * 4 + j * 4 + k]
                                ) / 5
                             );
                    }
                }
                else
                {
                    tbytes[i * width * 4 + j * 4] = bytes[i * width * 4 + (j) * 4];
                    tbytes[i * width * 4 + j * 4 + 1] = bytes[i * width * 4 + (j) * 4 + 1];
                    tbytes[i * width * 4 + j * 4 + 2] = bytes[i * width * 4 + (j) * 4 + 2];
                    tbytes[i * width * 4 + j * 4 + 3] = bytes[i * width * 4 + (j) * 4 + 3];
                }
            }
        }
        tex.LoadRawTextureData(tbytes);

        return tex;
    }

    /// <summary>
    /// 只针对除最外围一圈进行的加权抗锯齿
    /// 效果比不加权的更清晰，同时具有一定的平滑度（性能损失一般）
    /// </summary>
    /// <param name="tex"></param>
    /// <param name="width"></param>
    /// <param name="height"></param>
    /// <returns></returns>
    private Texture2D SimpleAntiAliasing1(Texture2D tex, int width, int height)
    {
        byte[] bytes = tex.GetRawTextureData();
        if (width * height * 4 != bytes.Length)
        {
            return tex;
        }
        byte[] tbytes = new byte[bytes.Length];
        for (int i = 1; i < height - 1; i++)
        {
            for (int j = 1; j < width - 1; j++)
            {
                for (int k = 0; k < 4; k++)
                {
                    tbytes[i * width * 4 + j * 4 + k] =
                        (byte)
                        (
                            (
                                bytes[i * width * 4 + (j) * 4 + k] * 6 +
                                bytes[i * width * 4 + (j - 1) * 4 + k] +
                                bytes[i * width * 4 + (j + 1) * 4 + k] +
                                bytes[(i - 1) * width * 4 + j * 4 + k] +
                                bytes[(i + 1) * width * 4 + j * 4 + k]
                            ) / 10
                         );
                }
            }
        }
        tex.LoadRawTextureData(tbytes);
        return tex;
    }
}

/// <summary>
/// 默认的图像大小配置
/// </summary>
public enum CameraRenderChoice
{
    default_2560x1920,
    small_256x192,
    large_5120x3840
}

/*//这个计时方法先留一留，晚点做性能方面的测试
 * System.Diagnostics.Stopwatch sw = new System.Diagnostics.Stopwatch();
        sw.Start();
sw.Stop();
 */