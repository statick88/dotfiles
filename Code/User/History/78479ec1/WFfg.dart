void main() {
    final String pokemon = 'Pikachu';
    final int hp = 100;
    final bool isAlive = true;
    final List<String>abilities = ['impostor'];
    final sprits = <String>['pikachu.png', 'pikachu2.png'];
    // dynamic == null
    dynamic errorMessage = 'Hola';
    errorMessage = true;
    errorMessage = 

    print("""
    $pokemon
    $hp
    $isAlive
    $abilities
    $sprits
    # $errorMessage 
    """);
}
