# ZTAnimation

### 波浪动画
<img src="/img/wave.gif" width="350" height="667">

##### 支持Storyboard和代码创建
```Swift

// @IBOutlet weak var waveView: WaveView!
        //颜色
//        waveView.waveColor = UIColor.blue
        //动画时间2s
        waveView.speed = 2
        //浪高
        waveView.amplitude = 8
        //波长
        waveView.wavelength = 320
        //持续动画
    // waveView.alwaysAnimation = true
```    

##### 调用
```Swift
waveView.startWave()
```
### 下拉刷新七彩泡泡动画
<img src="/img/refresh.gif" width="350" height="667"><br>

[详情参考简书](http://www.jianshu.com/p/871c569f779d)