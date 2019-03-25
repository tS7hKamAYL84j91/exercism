module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

orbitalPeriod :: Planet -> Float
orbitalPeriod Mercury = orbitalPeriod(Earth) * 0.2408467
orbitalPeriod Venus = orbitalPeriod(Earth) * 0.61519726 
orbitalPeriod Earth = 31557600.0
orbitalPeriod Mars = orbitalPeriod(Earth) * 1.8808158 
orbitalPeriod Jupiter = orbitalPeriod(Earth) * 11.862615
orbitalPeriod Saturn = orbitalPeriod(Earth) * 29.447498
orbitalPeriod Neptune = orbitalPeriod(Earth) * 164.79132
orbitalPeriod Uranus = orbitalPeriod(Earth) * 84.016846;


ageOn :: Planet -> Float -> Float
ageOn planet seconds = seconds / (orbitalPeriod planet)
