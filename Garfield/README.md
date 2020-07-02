# ConkyGarfield
Conky Manager Mod: Random Garfield Strip for Gnome Background

Usabel are two versions:
1. OneLine - One line Comic Strip 900x268px, located on the main monitor on the lower right side
2. ThreeLine - Three line Comic Strip 900x600px, located on the most left monitor on the lower right side

**Attend** Init Content Loader

The picloader.sh script will download initially 2 years of Garfield Strips into ~/Pictures/Conky/Garfield,
you can change this Linux Date Value with all allowed Date Formats. 

I rcommend the easy way e.g. 2 week ago / 2 year ago /.. in picloader.sh  LN: 23 var 'LOAD_GARFIELD_SINCE'
```
LOAD_GARFIELD_SINCE="2 year ago"
```

**Set Update Interval**

In the Conky Scrips: garfield_OneLine / garfield_ThreeLine search line 

```
update_interval 120
```
The int value is the timeout expression in seconds, change to the value you need, but remind that each start of the gnome shell or conky script will run the script and load and exchange the strip. 


**Troubles**

- It can be that the script window settings does not match your window manager profile / hardware, in thus chases exchange in the 
garfield_*Line conky script the window section with this:

```
# -- Window specifications -- #
 
own_window yes
own_window_type desktop
own_window_transparent yes
own_window_hints undecorate,sticky,skip_taskbar,skip_pager,below
own_window_colour 000000
own_window_argb_visual no
own_window_argb_value 200
```
- It can be, that you require some additional linux bash tools, as
   - curl
   - identify
   - convert

basically those tools are provided within the standard packages, if not install them simply with your package manager of choice. 

