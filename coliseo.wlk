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
    var property armadura
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
    method recibirAtaque(num) {
        vida -= 0.max(num)
    }
    method puedePelear() = vida > 0
}
class Mirmillon inherits Gladiador {

    override method arma() = espada
    override method armadura() = escudo.puntos(self) + casco.puntos(self)
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
        const nuevoGrupo new Grupo(nombre="mirmillolandia", cantPeleas=0, gladiadores=[gladiadores, self])
        return nuevoGrupo
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
        return new Grupo(nombre="D-" + self.sumarPoderes(gladiadores), cantPeleas=0, gladiadores=[gladiadores, self])
    }
    method sumarPoderes(gladiadores) {
        return gladiadores.sum({g => g.ataque()}) + self.ataque()
    }
}

object casco {
    method puntos(unGladiador) = 10
}
object escudo {
    method puntos(unGladiador) = 5 + (unGladiador.destreza() * 0.1)
}

class Grupo {
    const nombre
    var cantPeleas
    const gladiadores

    method aumentarPeleas(){
        cantPeleas += 1
    }
    method agregarGladiador(unGladiador) {
        gladiadores.add(unGladiador)
    }
    method sacarGladiador(unGladiador) {
        gladiadores.remove(unGladiador)
    }
    method combatir(unGrupo) {
        self.aumentarPeleas()
        unGrupo.aumentarPeleas()
        [1..3].forEach({r => self.elMasFuerte().combatir(unGrupo.elMasFuerte())})
    }
    method elMasFuerte() {
        const puedenPelear = gladiadores.filter({g => g.puedePelear()})
        if (puedenPelear.isEmpty()) {
            self.error("No hay gladiadores que puedan pelear")
        }
        else {
            return puedenPelear.max({g => g.fuerza()})
        }
    }
    method curarATodos() {
        gladiadores.forEach({g => g.curar()})
    }
}

//NOOOOOOOOOOO
// class Combate {
//     var property campeon
//     var property grupo1
//     var property grupo2

//     method combatir(participe1, participe2) {
//         grupo1.combatirA(grupo2)
//     }
//     method curar() {
//         grupo1.forEach({c => c.curar()})
//         grupo2.forEach({c => c.curar()})
//     }
    
// }