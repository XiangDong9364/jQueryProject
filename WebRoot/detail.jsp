<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<!-- 引用外部样式 -->
<link rel="stylesheet" href="css/base.css" type="text/css" />
<link rel="stylesheet" href="css/detail.css" type="text/css" />
<link rel="stylesheet" href="css/skin_0.css" id="file" />
<link rel="stylesheet" href="css/thickbox.css" />

<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script src="js/jquery.jqzoom.js"></script>
<script src="js/jquery.cookie.js"></script>
<script src="js/jquery.thickbox.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>jQueryProject-商品详情</title>
<style>
@import url("css/zoom.css");
</style>
<!-- HTML中给地址栏添加icon图标 -->
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
<script type="text/javascript">
	$(document).ready(function(){
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
		
		// 放大镜
		$(".jqzoom").jqueryzoom({
			xzoom: 300,	// 放大层的宽
			yzoom: 300,	// 放大层的高
			offset: 20,	// 坐标
			position: "right" ,// 显示的位置
			lens:1, // 是否显示放大镜
			preload: 1 //预加载大图
		})
		
		// 点击下方的图片更换上方大图  live可使用于新添加的元素
		$(".imgList li img").live("click",function(){
			// 1.获取当前img的路径
			var imgsrc = $(this).attr("src");
			
			console.log(imgsrc); // img/pro_img/blue_one.jpg
			
			var index = imgsrc.lastIndexOf(".");
			var extend = imgsrc.substring(index); // .jpg
			var path = imgsrc.substring(0,index); // img/pro_img/blue_one
			
			// 小图路径 img/pro_img/blue_one_small.jpg
			small_path = path + "_small" + extend;
			
			// 大图路径
			big_path = path + "_big" + extend;
			
			// 设置显示图片
			$("#bigImg").attr("src",small_path).attr("jqimg",big_path);
			
			// 设置弹出层的图片
			$("#thickI").attr("href",big_path);
		})
		
		// 更换衣服颜色的img点击事件
		$(".color_change li img").click(function(){
			var imgsrc = $(this).attr("src");
			
			// 获取 该图片的 alt
			var dressColor = $(this).attr("alt")
			
			// 改变 颜色
			$("#dressColor").html("<h4>颜色：" + dressColor + "</h4>")
			
			var index = imgsrc.lastIndexOf("."); // 点的索引
					var extend = imgsrc.substring(index); // .jpg
					var path = imgsrc.substring(0,index); // img/pro_img/blue
					
					path_small = path+"_one_small"+extend;  // 小图路径
					path_big = path+"_one_big"+extend;// 大图路径
					
					// 设置中等大小的图片
					$("#bigImg").attr("src",path_small).attr("jqimg",path_big);
					
					$("#thickImg").attr("href",path_big)
					
					// 清空原来的所有li,根据名称加载相应位置的li
					
					$(".imgList").empty().load(path + ".html")
		})
		
		//设置默认第一个标题栏选中状态 
			$("#tabControl1").addClass("theme").css("color","white");
			$("#tabContent1").addClass("selectedTabContent");

			// 设置标题的点击事件
			$(".tabControl").click(function(){
				//移除选中效果
				$(".tabControl").removeClass("theme").css("color","black");
				$(".tabContent").removeClass("selectedTabContent");
				
				//添加选中的效果
				var index = $(this).index(); // 当前对象的索引
				$(this).addClass("theme").css("color","white");
				$("#tabContent"+(index+1)).addClass("selectedTabContent");

			});
			
			
			// 1.计算出你当前选择的是第几颗星星
		$("#star").on(
			"mousemove" , function(evt) {
				// 所用事件都会产生一个evnet对象
				var e = window.even || evt; //兼容写法
				// offset事件源元素的坐标
				console.log("offsetX=" + e.offsetX);
				// 2.分别算出x和y位置
				if (e.offsetX < 5) {
					$(this).css("background-position", "0px 0px")
				}
				if (e.offsetX >= 5 && e.offsetX < 15) {
					// 一颗星
					$(this).css("background-position", "0px -96px")
				}
				if (e.offsetX >= 15 && e.offsetX < 30) {
					// 两颗星
					$(this).css("background-position", "0px -112px")
				}
				if (e.offsetX >= 30 && e.offsetX < 45) {
					// 三颗星
					$(this).css("background-position", "0px -128px")
				}
				if (e.offsetX >= 45 && e.offsetX < 60) {
					// 四颗星
					$(this).css("background-position", "0px -144px")
				}
				if (e.offsetX >= 60 && e.offsetX < 80) {
					// 五颗星
					$(this).css("background-position", "0px -160px")
				}

			}
		)
		// 3.改变css()
		$("#star").on({
			"click" : function(evt) {
				// 所用事件都会产生一个evnet对象
				var e = window.even || evt; //兼容写法
				// offset事件源元素的坐标
				console.log("offsetX=" + e.offsetX);
				var x = 0; // 初始变量
				// 2.分别算出x和y位置
				if (e.offsetX < 5) {
					x = 0;
					$(this).css("background-position", "0px 0px")
				}
				if (e.offsetX >= 5 && e.offsetX < 15) {
					// 一颗星
					x = 1;
					$(this).css("background-position", "0px -16px")
				}
				if (e.offsetX >= 15 && e.offsetX < 30) {
					// 两颗星
					x = 2;

					$(this).css("background-position", "0px -32px")
				}
				if (e.offsetX >= 30 && e.offsetX < 45) {
					// 三颗星
					x = 3;

					$(this).css("background-position", "0px -48px")
				}
				if (e.offsetX >= 45 && e.offsetX < 60) {
					// 四颗星
					x = 4;

					$(this).css("background-position", "0px -64px")
				}
				if (e.offsetX >= 60 && e.offsetX < 80) {
					// 五颗星
					x = 5;
					$(this).css("background-position", "0px -80px")
				}
				$("#score").html("商品评价：你评价的是"+x+"星!")
				$(this).off("mousemove");
				$(this).off("click")

			}
		})
		
		// 设置 尺寸
		$(".size li").on("click",function(){
			// 清空 所有li 的样式
			$(".size li").css({
					"background":"",
					"color":""});
				
			// 设置选中的样式
			$(this).css({
					"background":"red",
					"color":"white"
			})
			
			// 获取 选中的的值 并改变
			var size = $(this).text();
			$("#measure").html("<h4>尺寸：" + size + "</h4>");
			
		})
		
		// 设置总价
		$("#number").change(function(){
			var subPrice = $("#subPrice").text().substring(3);
			var value =$(this).children("option:selected").val(); //selected的值 
			// string --> int
			var intPrice = parseInt(subPrice);
			
			$("#totalPrice").html("<h4>总价：" + (intPrice * value) + "</h4>");
		})
		
		// 加入购物车
		$("#buy").click(function(){
			// 获取 商品名称
			var pName = "产品是：" + $("#productName").text() + ";";
			
			// 获取 尺寸
			var size = "\n尺寸是：" + $("#measure").text().substring(3) + ";";
			
			// 获取 颜色
			var color = "\n颜色是：" + $("#dressColor").text().substring(3) + ";";
			
			// 获取 数量
			var num = "\n数量是：" + $("#number").val() + ";";
			
			// 获取 总价
			var totalPrice = "\n总价是：" + $("#totalPrice").text().substring(3) + "。";
			
			// 弹窗字符串
			var strInfo = "  感谢您的购买。\n您购买的\n" + pName + size + color + num + totalPrice;
			
			confirm(strInfo);
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
					<ul style="margin-left: 30px">
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
				<ul style="margin-left: 40px">
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
			<h3 class="theme">&nbsp;&nbsp;商品信息</h3>
			<!-- 内容层左 -->
			<div class="contentL">
				<div class="global_module">
					<div class="pro_detail">
						<div class="pro_detail_left">
							<!-- 引用zoom.css样式  指定div的类名为jqzoom，给img添加jqimg属性(值为要显示的大图) -->
							<div class="jqzoom">
								<img src="images/pro_img/blue_one_small.jpg" class="fs" alt=""
									jqimg="images/pro_img/blue_one_big.jpg" id="bigImg" />
							</div>
						</div>
					</div>
				</div>
				<span style="position:absolute;left:100px;margin-top:20px;"> <a
					href="images/pro_img/blue_one_big.jpg" id="thickImg" title="卖衣服不咯？"
					class="thickbox"> <img alt="点击看大图" src="images/look.gif" />
				</a>
				</span>
				<!-- 中图层 -->
				<ul class="imgList">
					<li><img src="img/pro_img/blue_one.jpg" alt="" /></li>
					<li><img src="img/pro_img/blue_two.jpg" alt="" /></li>
					<li><img src="img/pro_img/blue_three.jpg" alt="" /></li>
				</ul>
				<!-- 选项卡切换 -->
				<div class="switch" >
					<div class="tabControl" id="tabControl1" style="margin-left: 0px">产品属性</div>
					<div class="tabControl" id="tabControl2" style="margin-left: 5px">产品尺码表</div>
					<div class="tabControl" id="tabControl3" style="margin-left: 5px">产品介绍</div>
					<div class="tabContent" id="tabContent1">
						产品属性内容、产品属性内容、产品属性内容、产品属性内容、 产品属性内容、产品属性内容、产品属性内容、产品属性内容、
						产品属性内容、产品属性内容、产品属性内容、产品属性内容、 产品属性内容、产品属性内容、产品属性内容、产品属性内容、
						产品属性内容、产品属性内容、产品属性内容、产品属性内容、 产品属性内容、产品属性内容、产品属性内容、产品属性内容、
						产品属性内容、产品属性内容、产品属性内容、产品属性内容、 产品属性内容、产品属性内容、产品属性内容、产品属性内容、
						产品属性内容、产品属性内容、产品属性内容、产品属性内容、</div>
					<div class="tabContent" id="tabContent2">
						产品尺码表内容、产品尺码表内容、产品尺码表内容、产品尺码表内容、 产品尺码表内容、产品尺码表内容、产品尺码表内容、产品尺码表内容、
						产品尺码表内容、产品尺码表内容、产品尺码表内容、产品尺码表内容、 产品尺码表内容、产品尺码表内容、产品尺码表内容、产品尺码表内容、
						产品尺码表内容、产品尺码表内容、产品尺码表内容、产品尺码表内容、 产品尺码表内容、产品尺码表内容、产品尺码表内容、产品尺码表内容、
						产品尺码表内容、产品尺码表内容、产品尺码表内容、产品尺码表内容、 产品尺码表内容、产品尺码表内容、产品尺码表内容、产品尺码表内容、</div>
					<div class="tabContent" id="tabContent3">
						产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、
						产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、
						产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、
						产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、
						产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、
						产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、产品介绍内容、
					</div>
				</div>
			</div>
			<!-- 内容层右 -->
			<div class="contentR">
				<h4 id="productName">免烫高支棉条纹衬衣</h4>
				<p>介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 
				      介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 
				      介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 
				      介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 
				      介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 
				      介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 
				      介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 
				      介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 介绍内容 
				</p>
				<h4 id="subPrice">现价：200元 <span style="text-decoration: line-through;">原价：300元</span></h4>
				<h4>编号：33313993</h4>
				<h4 id="dressColor">颜色：蓝白</h4>
				<!-- 颜色层 -->
				<div class="color_change">
					<ul>
						<li><img src="images/pro_img/blue.jpg" alt="蓝白" /></li>
						<li><img src="images/pro_img/yellow.jpg" alt="黄白" /></li>
						<li><img src="images/pro_img/green.jpg" alt="粉绿" /></li>
					</ul>
				</div><br /><br />
				<h4 id="measure">尺寸：未选择</h4>
				<div class="size">
					<ul>
						<li style="margin-left: 0px;">S</li>
						<li>L</li>
						<li>SL</li>
						<li>LL</li>
					</ul>
				</div>
				<br/><br/><br/>
				<b>数量：<select id="number">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
					</select>
				</b><br/><br/>
				<h4 id="totalPrice">总计：0元</h4><br/>
				<h4 id="score">商品评价：</h4>
					<div id="star"></div>
				<br /><br />
				<img alt="加入购物车" src="images/btn_cart.png" id="buy" />
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