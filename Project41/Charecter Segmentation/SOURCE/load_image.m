function [pwd,image_file]=load_image;
clear;
more off;
echo off;
clc;

[image_file,pwd] = uigetfile('*.bmp','Open Image File');

if (image_file == 0)
   if (pwd == 0)
      return;
   end
end

pwd_image_file = strcat(pwd,image_file);

info = imfinfo(pwd_image_file);
[x,map] = imread(pwd_image_file);
image(x);
colormap(map);