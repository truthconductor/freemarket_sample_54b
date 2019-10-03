class JointController < ApplicationController

  def index
   @item ={name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"}
   @items={name:"メルカリ",price:"1,500",image:"メルカリ画像.jpeg"},{name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"},{name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"},{name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"},{name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"},{name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"},{name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"},{name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"},{name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"},{name:"メルカリさん",price:"1,500",image:"メルカリ画像.jpeg"}
   @categoly="レディース"
   @categolies=["レディース","メンズ","家電・スマホ・カメラ","おもちゃ・ホビー・グッズ"]
  end
end
