class JointController < ApplicationController

  def index
   @item ={name:"メルカリさん",price:"1,500",image:"item-sample.jpg"}
   @items={name:"メルカリ",price:"1,500",image:"item-sample.jpg"},{name:"メルカリさん",price:"1,500",image:"item-sample.jpg"},{name:"メルカリさん",price:"1,500",image:"item-sample.jpg"},{name:"メルカリさん",price:"1,500",image:"item-sample.jpg"},{name:"メルカリさん",price:"1,500",image:"item-sample.jpg"},{name:"メルカリさん",price:"1,500",image:"item-sample.jpg"},{name:"メルカリさん",price:"1,500",image:"item-sample.jpg"},{name:"メルカリさん",price:"1,500",image:"item-sample.jpg"},{name:"メルカリさん",price:"1,500",image:"item-sample.jpg"},{name:"メルカリさん",price:"1,500",image:"item-sample.jpg"}
   @categoly="レディース"
   @categolies=["レディース","メンズ","家電・スマホ・カメラ","おもちゃ・ホビー・グッズ"]
  end
end
