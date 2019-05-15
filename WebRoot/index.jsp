<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<!-- 引用外部样式 -->
<link rel="stylesheet" href="css/base.css" type="text/css" />
<link rel="stylesheet" href="css/index.css" type="text/css" />
<link rel="stylesheet" href="css/skin_0.css" id="file" />

<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script src="js/jquery.cookie.js"></script>
<script src="js/jquery.color.js"></script>
<title>jQueryProject-首页</title>

<!-- HTML中给地址栏添加icon图标 -->
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />

<script>
	$(document).ready(function() {
		//  1.给所有的衣服加放大镜，遍历所有的td
		$(".contentRD table td").each(function(){
			// 获取图片所在位置
			var $pos = $(this).find("img").position();
			var top = $pos.top;
			var left = $pos.left;
			
			// 获取图片宽和高
			var width = $(this).find("img").width();
			var height = $(this).find("img").height();
			
			// 创建span元素放大镜
			var $span = $("<span></span>");
			
			$span.css("position","absolute").css("top",top).
			css("left",left).css("width",width).css("height",height);
			
			$span.addClass("span1");
			
			$(this).find("img").after($span)
		})
		
		// 放大镜悬停事件
		$(".span1").hover(function(){
			$(this).addClass("spanOver");
		},function(){	
			$(this).removeClass("spanOver");
		})

		// 隐藏顶部菜单内的下拉列表内容
		$(".topMenu").find("ul li").hide();

		// 顶部菜单鼠标事件
		$(".topMenu").hover(function() {
			if (!$(this).find("ul li").is(":animated")) {
				// 设置滑动显示
				$(this).find("ul li").slideDown("slow");
				// jquery中动画的css对象只能更改数值。
				// 使用jquery.color.js插件后可以更换背景颜色
				$(this).find("ul>li>a").hover(function() {
					// 移入
					$(this).parent().css("background","#00d250"); // 改变父标签li背景颜色
					$(this).css("color","white") // 改变字体颜色
				},function() {
					// 移出
					$(this).parent().css("background",""); // 移出父标签li背景颜色
					$(this).css("color","")// 移出字体颜色
				})
			}
		},function() {
			// 移出
			if (!$(this).find("ul li").is(":animated")) {
				// 设置滑动隐藏
				$(this).find("ul li").slideUp("slow");
			}
		})

		// 读取一个用户选择的skin的cookie
		var mySkin = $.cookie("mySkin");

		// 改变皮肤
		changSkin(mySkin)

		// 更换皮肤
		$("#skinSelect ul>li").click(function() {
			// 获取选中的 li 的ID属性
			var skinName = $(this).attr("id"); // skin_0
			console.log(skinName)
			changSkin(skinName);

			// 保存cookie数据，存放在用户的电脑上
			$.cookie("mySkin", skinName, {
				expires : 7, //过期时间:天
				path : "/" // 保存路径
			});
		})

		/*===============新闻动态================*/
		var timerNews; // 创建一个计时器变量

		timerNews = setInterval(function() { // 创建一个计时器  
			// 滚动一行的距离
			// 每隔 _ ms 调用该方法
			scrollList();
		}, 6000)

		$(".contentLT ul").hover(function() {
			// 清除计时器 鼠标悬停
			clearInterval(timerNews);
		}, function() {
			// 创建计时器 鼠标移出
			timerNews = setInterval(function() { // 创建一个计时器  
				// 滚动一行的距离
				// 每隔 _ ms 调用该方法
				scrollList();
			}, 6000)
		})

		function scrollList() {
			// 获取第一个li的行高
			var height = $(".contentLT ul li:first").height();
			$(".contentLT ul").animate({
				"top" : "-height"
			}, 500, function() {
				// 把第一行li添加到末尾
				$(this).append($(".contentLT ul li:first"));
			})
		}

		$(".contentLT img").click(function() {
			// 向下改为向上 关闭
			if ($(this).attr("src") == "images/down.gif") {
				$(this).attr("src", "images/up.gif");
				$(".contentLT").css("height", "30px");
			} else {
				// 向上改为向下 开起
				$(this).attr("src", "images/down.gif")
				$(".contentLT").css("height", "155px")
			}
		})

		/*==========产品分类==========*/
		$(".contentLD img").click(function() {
			// 向下改为向上 关闭
			if ($(this).attr("src") == "images/down.gif") {
				$(this).attr("src", "images/up.gif");
				$(".contentLD").css("height", "30px")
			} else {
				// 向上改为向下 开起
				$(this).attr("src", "images/down.gif")
				$(".contentLD").css("height", "365px")
			}
		})

		$(".product").click(function() {
			if ($(this).find("ul").css(
					"display") == "block") {
				// 状态：展开    目标： 关闭并更换图片为收齐
				$(this).find("ul").hide(600);
				$(this).css("list-style-image","url('images/treeview-collapsed.gif')");
			} else {
				// 状态：收齐    目标： 开启并更换图片为展开
				$(this).find("ul").show(600);
				$(this).css("list-style-image","url('images/treeview-expanded.gif')");
			}
		})

						var index = 1;
						var timerSlider; // 创建一个计时器
						// 创建计时器
						timerSlider = setInterval(function() {
							changeAd(index); // 改变图片
							index++; // 索引加一
							if (index == 5) {
								index = 0;
							}
						}, 4000);
						$(".num li").mouseover(function() {
							// 清除计时器
							clearInterval(timerSlider);
						}).mouseout(function() {
							// 创建计时器
							timerSlider = setInterval(function() {
								changeAd(index); // 改变图片
								index++; // 索引加一
								if (index == 5) {
									index = 0;
								}
							}, 4000);
						});

						$(".num li").mousemove(function() {
							index = $(this).index();
							changeAd(index);
						});
						
						// 图片左右切换
						$(".turnLR img").click(function() {
							// 判断用户点击的是向左还是向右
							if ($(this).attr("src") == "images/left.gif") {
								// 左 : 获取所有的TD 找到最后一个 删除并添加到第一个
								var $lastTd = $(".contentRD table td:last");
								$lastTd.remove();
								var $td = $("<td" + $lastTd.html() + "</td>")
								$(".contentRD table tr").prepend($lastTd);
							} else {
								// 右 : 获取所有的TD 找到第一个删除并添加到最后一个
								var $firstTd = $(".contentRD table td:first");
								$firstTd.remove();
								$(".contentRD table tr").append($firstTd);
							}
						})

					})

	function changSkin(skinName) { // skin_0
		// 删除选中的样式
		$(".selected").removeClass("selected");
		// id为skinName的添加样式
		$("#" + skinName).addClass("selected");
		// 改变link标签 引入的样式
		$("#file").attr("href", "css/" + skinName + ".css");

	}

	function changeAd(index) {
		$(".selected").removeClass("selected");

		$(".num li").eq(index).addClass("selected");

		var left = index * 1200;
		if (!$(".slider").is(":animated")) {
			$(".slider").animate({
				"left" : -left
			}, 600);
		}
	}
</script>
</head>

<body>
	<!-- 包裹层：最大层 -->
	<div class="wrap">
		<!-- 顶部层 -->
		<div class="top">
			<!-- 顶部上部 -->
			<div class="topUp theme">
				<!-- 颜色选择 -->
				<div id="skinSelect">
					<ul>
						<li class="skin_0" id="skin_0"></li>
						<li class="skin_1" id="skin_1"></li>
						<li class="skin_2" id="skin_2"></li>
						<li class="skin_3" id="skin_3"></li>
						<li class="skin_4" id="skin_4"></li>
						<li class="skin_5" id="skin_5"></li>
					</ul>
				</div>
				<span>&nbsp;&nbsp;XiangDong Shopping</span>
			</div>
			<!-- 顶部下部 -->
			<div class="topDown theme">
				<ul>
					<li class="topMenu"><a href="index.jsp">首页</a></li>
					<li class="topMenu"><a href="#">衬衫</a>
						<ul>
							<li><a href="#">&nbsp;&nbsp;短袖衬衫</a></li>
							<li><a href="#">&nbsp;&nbsp;长袖衬衫</a></li>
							<li><a href="#">&nbsp;&nbsp;无袖衬衫</a></li>
						</ul></li>
					<li class="topMenu"><a href="#">卫衣</a>
						<ul>
							<li><a href="#">&nbsp;&nbsp;开襟卫衣</a></li>
							<li><a href="#">&nbsp;&nbsp;套头卫衣</a></li>
						</ul></li>
					<li class="topMenu"><a href="#">裤子</a>
						<ul>
							<li><a href="#">&nbsp;&nbsp;休闲裤</a></li>
							<li><a href="#">&nbsp;&nbsp;免烫卡其裤</a></li>
							<li><a href="#">&nbsp;&nbsp;牛仔裤</a></li>
							<li><a href="#">&nbsp;&nbsp;短裤</a></li>
						</ul></li>
					<li class="topMenu"><a href="#">联系我们</a></li>
				</ul>
			</div>
		</div>
		<!-- 内容层 -->
		<div class="content">
			<!-- 内容层Left -->
			<div class="contentL">
				<!-- 内容层左上 -->
				<div class="contentLT">
					<img alt="▼" src="images/down.gif">
					<h3 class="theme">&nbsp;&nbsp;最新状态</h3>
					<ul>
						<li><a href="#" class="tooltip" title="甜美宽松毛衣今秋一定红.">甜美宽松毛衣今秋一定红.</a>
						</li>
						<li><a href="#" class="tooltip" title="秋装百搭小马甲不到50元.">秋装百搭小马甲不到50元.</a>
						</li>
						<li><a href="#" class="tooltip" title="修身韩版小西装万人疯抢.">修身韩版小西装万人疯抢.</a>
						</li>
						<li><a href="#" class="tooltip" title="夏末雪纺店主含泪大甩卖.">夏末雪纺店主含泪大甩卖.</a>
						</li>
						<li><a href="#" class="tooltip" title="瑞丽都疯狂推荐的秋装.">瑞丽都疯狂推荐的秋装.</a>
						</li>
						<li><a href="#" class="tooltip" title="48元长款针织小开衫卖疯啦.">48元长款针织小开衫卖疯啦.</a>
						</li>
						<li><a href="#" class="tooltip" title="长袖雪纺衫单穿内搭都超美.">长袖雪纺衫单穿内搭都超美.</a>
						</li>
					</ul>
				</div>
				<!-- 内容层左下 -->
				<div class="contentLD">
					<img alt="▼" src="images/down.gif">
					<h3 class="theme">&nbsp;&nbsp;产品分类</h3>
					<ul>
						<li class="product"><a href="#">衬衫</a>
							<ul>
								<li><a href="#">短袖衬衫</a></li>
								<li><a href="#">长袖衬衫</a></li>
								<li><a href="#">无袖衬衫</a></li>
							</ul></li>
						<li class="product"><a href="#">卫衣</a>
							<ul>
								<li><a href="#">开襟卫衣</a></li>
								<li><a href="#">套头卫衣</a></li>
							</ul></li>
						<li class="product"><a href="#">裤子</a>
							<ul>
								<li><a href="#">休闲裤</a></li>
								<li><a href="#">免烫卡其裤</a></li>
								<li><a href="#">牛仔裤</a></li>
								<li><a href="#">短裤</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
			<!-- 内容层Right -->
			<div class="contentR">
				<!-- 内容层右上 -->
				<div class="contentRT">
					<ul class="slider">
						<li><img src="images/ads/1.gif " /></li>
						<li><img src="images/ads/2.gif " /></li>
						<li><img src="images/ads/3.gif " /></li>
						<li><img src="images/ads/4.gif " /></li>
						<li><img src="images/ads/5.gif " /></li>
					</ul>
					<ul class="num">
						<li>1</li>
						<li>2</li>
						<li>3</li>
						<li>4</li>
						<li>5</li>
					</ul>
				</div>
				<!-- 内容层右下 -->
				<div class="contentRD">
					<div class="turnLR">
						<img alt="◀" src="images/left.gif" />
						<img alt="▶" src="images/right.gif" />
					</div>
					<h3 class="theme">&nbsp;&nbsp;新款上市</h3>
					<table>
						<tr>
							<td><img src="images/img_1.jpg" /><a href="detail.jsp">免烫高支棉衬衣1</a>
								<p>$120.00</p></td>
							<td><img src="images/img_2.jpg" /><a href="detail.jsp">免烫斜纹衬衣1</a>
								<p>$129.00</p>
							<td><img src="images/img_3.jpg" /><a href="detail.jsp">棉小方格正装衬衣1</a>
								<p>$129.00</p></td>
							<td><img src="images/img_4.jpg" /><a href="detail.jsp">小米兰格衬衣蓝色1</a>
								<p>$129.00</p></td>
							<td><img src="images/img_1.jpg" /><a href="detail.jsp">免烫高支棉衬衣2</a>
								<p>$170.00</p></td>
							<td><img src="images/img_2.jpg" /><a href="detail.jsp">免烫斜纹衬衣2</a>
								<p>$199.00</p>
							<td><img src="images/img_3.jpg" /><a href="detail.jsp">棉小方格正装衬衣2</a>
								<p>$199.00</p></td>
							<td><img src="images/img_4.jpg" /><a href="detail.jsp">小米兰格衬衣蓝色2</a>
								<p>$199.00</p></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 底部层 -->
		<div class="bottom theme">
			<hr /><br />
			<span><a>关于我们</a> | <a>商业合作</a> | <a>免责申明</a> | <a>隐私条款</a></span>
			<br /><br />
			<span>Copyright 2019 by Newer_XiangDong All rights reserved.</span>
		</div>
	</div>
</body>
</html>
