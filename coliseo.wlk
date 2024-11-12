class ArmasDeFilo {
    var filo
    const longitud
    

    method ataque() = filo * longitud
}
object espada {

}
object daga {
    
}
object hacha {
    
}
object maza {

}
object martillo {

}

class ArmasContundentes {
    const peso
    
    method ataque() = peso
}

class Gladiador {
    var property fuerza
    var property arma
    var vida = 100
    const property armadura
    var property destreza

    method ataque()
    method cambiarArma(unArma) {
        arma = unArma
    }
    method atacar(unGladiador)
    method defenderse()
    method cambiarArmadura(anterior, nueva) {
        armadura.remove(anterior)
        armadura.add(nueva)
    }
    method contraataque(unGladiador) {
        self.atacar(unGladiador)
    }
    method crearGrupoCon(gladiadores)
    method curar() {
        vida = 100
    }
}
class Mirmillon inherits Gladiador {

    override method arma() = espada
    override method armadura() = escudo.puntos() + casco.puntos()
    override method destreza() = 15
    override method atacar(unGladiador) {
        unGladiador.recibirAtaque(self.ataque() - unGladiador.defenderse())
    }
    override method ataque() = arma.ataque() + self.fuerza()
    override method defenderse() = self.puntosArmadura()
    method puntosArmadura() {
        return armadura.sum({a => a.puntos()})
    }
    override method crearGrupoCon(gladiadores) {
        return new Grupo(nombre="mirmillolandia", cantPeleas=0, gladiadores=gladiadores + self)
    }
}
class Dimachaerus inherits Gladiador {
    override method armadura() = 0
    override method fuerza() = 10
    override method atacar(unGladiador) {
        unGladiador.recibirAtaque(self.ataque() - unGladiador.defenderse())
        self.aumentarDestreza(1)
    }
    override method ataque() = self.fuerza() + self.totalArmas()
    method totalArmas() = arma.sum({a => a.ataque()})
    method aumentarDestreza(cantidad) {
        destreza += cantidad
    }
    override method defenderse() = destreza / 2
    override method crearGrupoCon(gladiadores) {
        return new Grupo(nombre="D-" + self.sumarPoderes(gladiadores), cantPeleas=0, gladiadores=gladiadores + self)
    }
    method sumarPoderes(gladiadores) {
        return gladiadores.sum({g => g.ataque()}) + self.ataque()
    }
}

object casco {
    method puntos() = 10
}
object escudo {
    method puntos() = 5 + (Gladiador.destreza() * 0.1)
}

class Grupo {
    const nombre
    var cantPeleas
    const gladiadores

    method agregarGladiador(unGladiador) {
        gladiadores.add(unGladiador)
    }
    method sacarGladiador(unGladiador) {
        gladiadores.remove(unGladiador)
    }
    method combatirA(unGrupo) {
        return new Combate(campeon=self.elMasFuerte())
        unGrupo.forEach({c => c.combatirA(self)})
    }
    method elMasFuerte() {
        if (gladiadores.max({g => g.fuerza()}).vida() > 0) {
            return gladiadores.max({g => g.fuerza()})
        }
        else {
            return
        }
    }
}
class Combate {
    var property campeon
    var property grupo1
    var property grupo2

    method combatir(participe1, participe2) {
        grupo1.combatirA(grupo2)
    }
    method curar() {
        grupo1.forEach({c => c.curar()})
        grupo2.forEach({c => c.curar()})
    }
    
}