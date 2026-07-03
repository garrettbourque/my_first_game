



--[[episode 10 pong game



local winningScore =5
gameOver =false
winner =nil


function love.load()
    love.window.setTitle("Pong Game")
    love.window.setMode(800,600) --width x height

    --paddle and ball constants
    local PADDLE_WIDTH = 20
    local PADDLE_HEIGHT =100
    local BALL_SIZE =20
    score1 = 0
    score2 = 0


    --sounds
    bounceSound = love.audio.newSource("sounds/blip1.wav","static")
    scoreSound = love.audio.newSource("sounds/blip2.wav","static")


    --left paddle
    player1 = {
        x=50,
        y=250,
        width = PADDLE_WIDTH,
        height = PADDLE_HEIGHT
    }
    
    --right paddle
      player2 = {
        x=800-50,
        y=250,
        width = PADDLE_WIDTH,
        height = PADDLE_HEIGHT
    }

    --ball
    ball = {
        x=400-BALL_SIZE/2,
        y=300-BALL_SIZE/2,
        size=BALL_SIZE
    }

    --initial speed for ball
    ball.dx=200--horizontal speed
    ball.dy=200--vertical speed
end

function love.draw()
    if gameOver then
        love.graphics.setFont(love.graphics.newFont(36))
        love.graphics.printf(winner.. " Wins !",0,250,800, "center")
        love.graphics.setFont(love.graphics.newFont(20))
        love.graphics.printf("Press R to restart",0,300,800, "center")
            return --stop drawing padddles and ball when game ends
    end
    --sett background color
    love.graphics.setBackgroundColor(.1, .1, .1)
    
    --draw the dashed line at center
    love.graphics.setColor(1,1,1)
    for i=0, 600,30 do
        love.graphics.rectangle("fill",395,i,10,15)
    end

    --draw paddles
    love.graphics.rectangle("fill",player1.x,player1.y,player1.width,player1.height)
    love.graphics.rectangle("fill",player2.x,player2.y,player2.width,player2.height)

    --draw ball
    love.graphics.rectangle("fill",ball.x,ball.y,ball.size,ball.size)


    local scoreFont = love.graphics.newFont(40)
    love.graphics.setFont(scoreFont)

    --show score
    --love.graphics.printf(score1,x, y, limit, align)
    
     love.graphics.printf(score1,0, 50, 400, "center")
     love.graphics.printf(score2,400, 50, 400, "center")
     

    --love.graphics.print(score1, 300, 50)
    --love.graphics.print(score2, 470, 50)

end

local function checkCollision (ball,paddle)
    return ball.x <= paddle.x + paddle.width and
        ball.x + ball.size >= paddle.x and
        ball.y <= paddle.y + paddle.height and
        ball.y + ball.size >= paddle.y

end

local function resetBall()
    ball.x = 400 - ball.size/2
    ball.y = 300 - ball.size/2
    ball.dx = 200* (math.random(2) == 1 and 1 or -1)
    ball.dy = 200* (math.random(2) == 1 and 1 or -1)

end

function love.update(dt)

    --check for winner
    if score1>= winningScore then
        gameOver =true
        winner = "Player1"
        return
    elseif score2>=winningScore then
        gameOver = true
        winner = "Player1"
        return
    end


    local speed =300 --pixels per second
    if love.keyboard.isDown("w") then
        player1.y=math.max(0, player1.y - speed*dt)
    elseif love.keyboard.isDown("s")then
        player1.y=math.min(600-player1.height,player1.y + speed*dt)
    end

        if love.keyboard.isDown("up") then
        player2.y=math.max(0, player2.y - speed*dt)
    elseif love.keyboard.isDown("down")then
        player2.y=math.min(600-player2.height,player2.y + speed*dt)
    end

    --move ball
    ball.x=ball.x+ball.dx*dt
    ball.y=ball.y+ball.dy*dt

    if ball.y<=0 then
       love.audio.play(bounceSound)

        ball.y=0
        ball.dy = -ball.dy
    elseif ball.y+ball.size>=600 then
        love.audio.play(bounceSound)

        ball.y=600-ball.size
        ball.dy= -ball.dy
    end

    if checkCollision(ball,player1) then
        ball.x = player1.x + player1.width --preventing overlap
        ball.dx = -ball.dx * 1.05  --bounce and to speed up
        love.audio.play(bounceSound)
    end
     if checkCollision(ball,player2) then
        ball.x = player2.x - ball.size --preventing overlap
        ball.dx = -ball.dx * 1.05  --bounce and to speed up
        love.audio.play(bounceSound)

    end

    if ball.x + ball.size < 0 then
        score2 = score2 + 1
        love.audio.play(scoreSound)
        resetBall()
    elseif ball.x>800 then
        score1 = score1 + 1
        love.audio.play(scoreSound)
        resetBall()
    end


end

function love.keypressed(key)
    if key=="r" and gameOver then
        score1 = 0
        score2 = 0
        gameOver = false
        winner = nil
        resetBall()
    end
    
end


]]



















--[[Episode 9 adding sounds
    .ogg --- looping background
    .wav short sound effects
    .mp3 cutscene intros
    freesound.org
    


    sounds = {love.audio.newSource("sounds/blip2.wav","static"),
    bgm = love.audio.newSource("sounds/electronicfluids.ogg","stream")
}

function playSound(name)
    if sounds[name]then
        sounds[name]:stop()
        sounds[name]:play()
    else
        print("Sound not found: "..name )
    end
end
playSound("bgm");
-- function love.load()
--     --short sound effect  (loaded into the memory)
--     soundBlip = love.audio.newSource("sounds/blip1.wav","static")

--     --Background music (streamed from disk to save memory)
--     bgMusic =love.audio.newSource("sounds/electronicfluids.ogg","stream")

--     --loop the music
--     bgMusic:setLooping(true)
--     bgMusic:play()
-- end

--     function love.keypressed(key)
--         if key=="p" then
--             if bgMusic:isPlaying() then
--                 bgMusic:pause()
--             else
--                 bgMusic:play()
--             end
--             soundBlip:stop() --stop if already playing
--             soundBlip:play()
--         end
-- end

-- function love.update(dt)
--     --volume control goes from 0.0 to 1.0
--     local currentVolume = bgMusic:getVolume()
--     if currentVolume>0 then
--         bgMusic:setVolume(currentVolume- 0.1*dt)
--     end

-- end
]]



--[[Episode 8 collision detection
function love.load()

    player= {x=100, y=100, width =50, height =50, speed =200}
    box ={x=300, y=100, width =100, height =100}
end

function love.draw()
    love.graphics.setColor(0,0.5,1)
    love.graphics.rectangle("fill",player.x,player.y,player.width,player.height)
    if CheckCollision(player.x,player.y,player.width,player.height,box.x,box.y,box.width,box.height) then
    love.graphics.setColor(0,1,0)
else
    love.graphics.setColor(1,0,0)
end
    love.graphics.rectangle("fill",box.x,box.y,box.width,box.height)
end

function love.update(dt)

    if love.keyboard.isDown("right") then
        player.x=player.x+player.speed*dt
   
    elseif love.keyboard.isDown("left") then
        player.x=player.x-player.speed*dt
    end

    if love.keyboard.isDown("down") then
        player.y=player.y+player.speed*dt
    elseif love.keyboard.isDown("up") then
        player.y=player.y-player.speed*dt
    end

    if CheckCollision(player.x,player.y,player.width,player.height,box.x,box.y,box.width,box.height) then
    print("Collision!")

end

end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1<x2+w2 and
    x2< x1+w1 and
    y1<y2+h2 and
    y2<y1+h1
end


]]

--[[
--Episode 7
local player={}
local speed =200
local frameTime = 0.1 --Time per frame in seconds
local elapsed =0 --tracks how much time ahs passed

function love.load()
    player.frames={
        love.graphics.newImage("sprite1.png"),
        love.graphics.newImage("sprite2.png"),
        love.graphics.newImage("sprite3.png"),
        love.graphics.newImage("sprite4.png")
    }
    player.currentFrame=1
    player.x, player.y =100,100
    player.faceingRight =true
    walk=love.audio.newSource("sounds/walk.mp3","static")
end

function love.update(dt)
    local moving =false
    if love.keyboard.isDown("right") then
        player.x=player.x+speed*dt
        player.facingRight=true
        moving=true
    end

    if love.keyboard.isDown("left") then
        player.x=player.x-speed*dt
        player.facingRight=false
        moving=true
    end

    if love.keyboard.isDown("down") then
        player.y=player.y+speed*dt
        moving=true
    end

    if love.keyboard.isDown("up") then
        player.y=player.y-speed*dt
        moving=true
    end
    
    --if moving, switch the naimation frames
    if moving then
        walk:play()
        elapsed=elapsed+dt
        if elapsed>=frameTime then
            elapsed=0
            player.currentFrame=player.currentFrame% #player.frames+1
        end
    else
        walk:stop()
        player.currentFrame=1
    end
end

function love.draw()
    local img = player.frames[player.currentFrame]
    if player.facingRight then
        love.graphics.draw(img,player.x,player.y,0, 2, 2)
    else
        love.graphics.draw(img,player.x+0.4*img:getWidth(), player.y,0, -2, 2)
    end
end
]]

--[[local player= {}
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
]]



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