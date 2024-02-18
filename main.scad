/**
如何增加斜边
存储尺寸
140长（再加10公分重合区域），90宽，150高
两个合并后，有重合的部分
底部增加1英寸轮子，约3里面高度
**/

//定义是否需要显示外壳
cover_on = 1;
color_alpha=0.3;

//初始尺寸
diameter=32;
thick=30;

l_length=500;
l_width=1400;
l_height=1400;

m_length=400;
m_width=l_width-2*thick-2*diameter; //1276mm
m_height=l_height-thick-diameter;  //1.4m

r_length=400;
r_width=l_width-4*thick-4*diameter; //1276mm
r_height=l_height-thick-diameter-thick-diameter;  //1.4m



/**以下是模块**/
module pipe_cube(x,y,z,d,m){
    //m=1时为中间的模块，下方不做横杆；
    //m=0时为首位的模块，西方需要横杆。
    for(i=[[0,0,d/2],[x+d,0,d/2],[0,y+d,d/2],[x+d,y+d,d/2]] ){
        translate(i)
    cylinder(h=z,d=d,center=false);
    }
    
    //前排轮子
    translate([x/8,-d/2,-30-d/2])
    cube([40,30,30]);
    translate([7*x/8,-d/2,-30-d/2])
    cube([40,30,30]);
    
    //后排轮子
    translate([x/8,y+d/2,-30-d/2])
    cube([40,30,30]);
    translate([7*x/8,y+d/2,-30-d/2])
    cube([40,30,30]);
    
    for(i=[[0,0,0],[0,0,z+d],[0,y+d,0],[0,y+d,z+d]]){
        translate(i){
    translate([d/2,0,0])
    rotate([0,90,0])
    cylinder(h=x,d=d,center=false);}}
    
    
    for(i=[[0,0,z+d],[x+d,0,z+d]]){
        translate(i)
    translate([0,d/2,0])
    rotate([-90,0,0])
    cylinder(h=y,d=d,center=false);}
    
    if(m==0){
        for(i=[[0,0,0]]){
        translate(i)
    translate([0,d/2,0])
    rotate([-90,0,0])
    cylinder(h=y,d=d,center=false);}
        }
    
    
    }


module pipe_cube_cover(x,y,z,d,t){
    translate([-d/2,-t-d/2,-d/2-30])
    color("red",alpha=color_alpha)
    cube([x+d*2,t,z+2*d+30]);
    
        translate([-d/2,y+d+d/2,-d/2-30]) 
      color("blue",alpha=color_alpha)  
    cube([x+d*2,t,z+2*d+30]);
    translate([-1*t-d/2,-d/2-t,-d/2-30])
        color("green",alpha=color_alpha)
    cube([t,y+2*t+2*d,z+2*d+30]);
    
    translate([-t-d/2-d,-t-d/2-d,z+d+d/2])
        color("pink",alpha=color_alpha)
    cube([x+2*d+4*t+t,y+2*t+2*t+2*d,t]);
    
    }

module pipe_cube_cover_m(x,y,z,d,t){
    translate([-d/2,-t-d/2,-d/2-30])
    color("red",alpha=color_alpha)
    cube([x+d*2,t,z+2*d+30]);
    
        translate([-d/2,y+d+d/2,-d/2-30]) 
      color("blue",alpha=color_alpha)  
    cube([x+d*2,t,z+2*d+30]);

    
    translate([-t-d/2+d,-t-d/2,z+d+d/2])
        color("pink",alpha=color_alpha)
    cube([x+2*d+4*t,y+2*t+2*d,t]);
    
    }   


module pipe_cube_cover_r(x,y,z,d,t){
    translate([-d/2,-t-d/2,-d/2-30])
    color("red",alpha=color_alpha)
    cube([x+d*2,t,z+2*d+30]);
    
        translate([-d/2,y+d+d/2,-d/2-30]) 
      color("blue",alpha=color_alpha)  
    cube([x+d*2,t,z+2*d+30]);
    translate([-1*t-d/2,-d/2-t,-d/2-30])
        color("green",alpha=color_alpha)
    cube([t,y+2*t+2*d,z+2*d+30]);
    
    translate([-t-d/2-d,-t-d/2-d,z+d+d/2])
        color("pink",alpha=color_alpha)
    cube([x+2*d+t+d,y+2*t+2*t+2*d,t]);
    
    }

module mount(x, y){
    cylinder(h=950,r=100,center=false);
    translate([0,0,950])
    rotate([30,0,0]){
        rotate([0,x,0]){
            rotate([90,0,0])
                color("black",0.5)
                cylinder(h=300,r=230,center=true);
            //SbS双镜
            rotate([0,0,y]){
                translate([-350,-500,230])
                cube([600,1300,350]);
            }
            //重锤    
            translate([-100,150,-600])
            cube([200,200,600]);
        }
    }
}


/**以下是各种定义**/
//左侧罩子
//translate([-1000,0,0])
{
pipe_cube(l_length,l_width,l_height,diameter,0);
 

if (cover_on==1){
{pipe_cube_cover(l_length,l_width,l_height,diameter,thick);}
}
}
//中间筒子

translate([l_length-50,thick+diameter,0])
{
pipe_cube(m_length,m_width,m_height,diameter,1);
 

if (cover_on==1){
{pipe_cube_cover_m(m_length,m_width,m_height,diameter,thick);
}
    }

}

//右侧罩子
translate([m_length+l_length+r_length-150+diameter*3,thick+diameter+(thick+diameter),0])
mirror([90,0,0]){
pipe_cube(r_length,r_width,r_height,diameter,0);
//color("red",alpha=0.6)
if (cover_on==1){
    pipe_cube_cover_r(r_length,r_width,r_height,diameter,thick);}
    }

translate([(l_length+m_length)/2+180,l_width/2-100,0])
mount(-90,30);

/**
//赤道仪mount全旋转
translate([l_length+50,l_width/2,0]){
intersection()
{
    for(y=[-1:-1])
for(x=[0:0])
{

mount(30*x,30*y);
}
}

intersection(){
    for(y=[-4:4])
for(x=[-3:3])
{

mount(30*x,30*y);
}}

}
**/

/**
左侧面板
    前面板：l_length+2*diameter，l_height++2*diameter+30
        964*1626
    后面板：l_length+2*diameter，l_height++2*diameter+30
        964*1626
    左侧面板：l_width+2*diameter+2*thick, l_height++2*diameter+30
        1024*1626
    上部面板：l_length+2*diameter+thick, l_width+2*diameter+2*thick
        994*1024
右侧面板
    前面板：r_length+2*diameter，r_height++2*diameter+30
        664*1594
    后面板：r_length+2*diameter，r_height++2*diameter+30
        664*1594
    右侧面板：r_width+2*diameter+2*thick, r_height++2*diameter+30
        928*1594
    上部面板：r_length+2*diameter+thick, r_width+2*diameter+2*thick
        694*928
        
左侧棍子
    立柱：４根l_height，1500mm
    前后：４根l_length，900mm,可以补充2根
    左侧：３根l_width，1400mm，可以补充1根
    立体三通：4个
    直角两通：4个
    平面三通：2个，补充6个
右侧棍子
    立柱：４根r_height 1460mm
    前后：４根r_length,600mm，可以补充2根
    右侧：３根r_width，1276mm，可以补充1根
    立体三通：4个
    直角两通：4个
    平面三通：2个，补充6个
    
    一共22根1.5米PVC管
**/