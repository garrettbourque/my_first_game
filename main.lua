local message =""

function love.keypressed(key)
    
        message = key.." was pressed!"
    
end


function love.draw()
    love.graphics.print(message,100,100)
end


















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