local target = {}
local score = 0
local timer = 30
local gameState = "play" -- "play" ou "gameover"

function love.load()
    -- Définition de la cible
    target.x = 100
    target.y = 100
    target.radius = 25
end

function love.update(dt)
    if gameState == "play" then
        -- Compte à rebours
        timer = timer - dt
        if timer <= 0 then
            timer = 0
            gameState = "gameover"
        end

        -- Déplacement de la cible au stylet / écran tactile
        if love.touch then
            local touches = love.touch.getTouches()
            for _, id in ipairs(touches) do
                local tx, ty = love.touch.getPosition(id)
                -- Vérifie si le joueur touche la cible
                local distance = math.sqrt((tx - target.x)^2 + (ty - target.y)^2)
                if distance < target.radius then
                    score = score + 1
                    -- Repositionne la cible au hasard sur l'écran tactile (320x240)
                    target.x = math.random(target.radius, 320 - target.radius)
                    target.y = math.random(target.radius, 240 - target.radius)
                end
            end
        end
    end
end

function love.draw()
    if gameState == "play" then
        -- Affichage sur l'écran du haut (400x240)
        love.graphics.print("Score: " .. score, 10, 10)
        love.graphics.print("Temps: " .. math.ceil(timer) .. "s", 300, 10)

        -- Dessin de la cible
        love.graphics.circle("fill", target.x, target.y, target.radius)
    else
        -- Écran de fin
        love.graphics.print("PARTIE TERMINEE !", 130, 100)
        love.graphics.print("Score final: " .. score, 140, 120)
    end
end
