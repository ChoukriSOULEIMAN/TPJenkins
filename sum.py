def additionner(arg1, arg2):
    """
    Additionne deux nombres et retourne le résultat.

    :param arg1: Premier nombre à additionner (float)
    :param arg2: Deuxième nombre à additionner (float)
    :return: La somme de arg1 et arg2 (float)
    """
    return arg1 + arg2


if __name__ == "__main__":
    result = additionner(5, 10)
    print(f"Le résultat est : {result}")
