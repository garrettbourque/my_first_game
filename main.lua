local player= {}
local speed = 200 --pixels per second

function love.load()
    player.image = love.graphics.newImage("bimage.png")
    player.x=100
    player.y=100
    player.facingRight=true --for sprite flipping
end

function love.update(dt)
if love.keyboard.isDown("right") then
    --player.x=player.x+speed*dt
    player.x=math.min(player.x+speed*dt, love.graphics.getWidth()-.1*player.image:getWidth())
    player.facingRight=true
end

if love.keyboard.isDown("left") then
    --player.x=player.x-speed*dt
    player.x=math.max(player.x-speed*dt, 0)
    player.facingRight=false
end

if love.keyboard.isDown("down") then
    --player.y=player.y+speed*dt
        player.y=math.min(player.y+speed*dt, love.graphics.getHeight()-.1*player.image:getHeight())

   
end

if love.keyboard.isDown("up") then
    --player.y=player.y+speed*dt
    player.y=math.max(player.y-speed*dt, 0)
end
end

function love.draw()
    if player.facingRight then
    love.graphics.draw(player.image, player.x, player.y,0,.1,.1)

    else
        --flip sprite to left
        love.graphics.draw(player.image, player.x + 0.1*player.image:getWidth(), player.y,0,-.1,.1)

    end


end




--testing png image manipulation
--[[
local character
local charWidth, charHeight

function love.load()
    character = love.graphics.newImage("bimage.png")
    charWidth = character:getWidth()
    charHeight = character:getHeight()
end

function love.draw()
    --love.graphics.draw(image,100,100, rotation, scaleX, scaleY)
    --love.graphics.draw(character,100,100)
    love.graphics.draw(character,50,50,0,.05,.05)

    love.graphics.print("Width: " .. charWidth,10,10)
    love.graphics.print("Width: " .. charHeight,10,30)

    --get screen size

    local screenW, screenH = love.graphics.getDimensions()

    love.graphics.draw(character, (screenW-charWidth)/2, (screenH-charHeight)/2)
    
end
]]


--[[moving a rectangle around
--position of rectangle
local x =100 
local y=100
local speed =200 --pixels per second


function love.update(dt) 
    if love.keyboard.isDown("right") then
        x=x+speed*dt
    elseif love.keyboard.isDown("left") then
        x=x-speed*dt
    end
     
    if love.keyboard.isDown("down") then
        y=y+speed*dt
    elseif love.keyboard.isDown("up") then
        y=y-speed*dt
    end
end

function love.draw()
    love.graphics.setColor(.2, .7, 1)
    love.graphics.rectangle("fill", x, y, 50, 50)
end
]]
--[[local message =""

function love.keypressed(key)
    
        message = key.." was pressed!"
    
end


function love.draw()
    love.graphics.print(message,100,100)
end
]]

















--basic love shape and drawing functions
--[[
local playerName ="Sam"
local score =0

function love.load()
    
end

--dt relates to how much time since the previous frame
function love.update(dt)
score =score+1
end


function love.draw()
   
    
    love.graphics.print("100,130",100,130)
    love.graphics.print("130,100",130,100)
    love.graphics.setColor(1,0,0)
    --Rectangle("method",x,y,width,height)
    love.graphics.rectangle("fill",50,50,70,60)

     love.graphics.setColor(0,1,0)
     --Circle("method",x,y,radius)
    love.graphics.circle("line",200,80,30)

     love.graphics.setColor(0,0,1)
    --Line(x1,y1,x2,y2)
    love.graphics.line(300,50,400,100)

    love.graphics.setColor(1,1,1)
    love.graphics.print("hellow world", 500, 50)
    
    love.graphics.print("Player: ".. playerName,50,200)
    love.graphics.print("Score: ".. score,50,230)


end

]]