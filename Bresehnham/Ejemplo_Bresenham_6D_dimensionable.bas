    ' d(i): diferencia entre posicion nueva y vieja en cada eje
    ' Ad(i): valor absoluto de d(i) - determina el eje dominante
    ' inc(i): incremento (+1 o -1) para cada eje
    
    Dim As Integer d(1 To 6), Ad(1 To 6), inc(1 To 6), dx2(1 To 6)
    Dim As Integer dim_(1 To 6)   ' posicion acumulada de cada eje
    Dim As Integer errr(1 To 5)   ' errores de los ejes no dominantes
    Dim As Integer Dom            ' indice del eje dominante
    Dim As Integer i, Conta

    ' Carga posiciones actuales y deltas
    dim_(1) = Xold : d(1) = EjeX - Xold
    dim_(2) = Yold : d(2) = EjeY - Yold
    dim_(3) = Zold : d(3) = EjeZ - Zold
    dim_(4) = Vold : d(4) = EjeV - Vold
    dim_(5) = Wold : d(5) = EjeW - Wold
    dim_(6) = Dold : d(6) = EjeD - Dold

    ' Calcula valores absolutos e incrementos de signo
    For i = 1 To 6
        Ad(i)  = Abs(d(i))
        inc(i) = Sgn(d(i))
        dx2(i) = Ad(i) * 2
    Next

    ' Determina el eje dominante (el de mayor recorrido)
    Dom = 1
    For i = 2 To 6
        If Ad(i) > Ad(Dom) Then Dom = i
    Next

    ' Solo interpola si hay movimiento efectivo
    If Ad(Dom) > 0 Then

        ' Inicializa errores para todos los ejes no dominantes
        Dim As Integer ei
        ei = 1
        For i = 1 To 6
            If i <> Dom Then
                errr(ei) = dx2(i) - Ad(Dom)
                ei = ei + 1
            EndIf
        Next

        For Conta = 1 To Ad(Dom)
            ' Avanza los ejes no dominantes segun el error acumulado
            ei = 1
            For i = 1 To 6
                If i <> Dom Then
                    If errr(ei) > 0 Then
                        dim_(i) += inc(i)
                        errr(ei) -= dx2(Dom)
                    EndIf
                    errr(ei) += dx2(i)
                    ei += 1
                EndIf
            Next

            ' Avanza el eje dominante en cada iteracion
            dim_(Dom) += inc(Dom)

            ' Aplica la nueva posicion y calcula cinematica
            EjeX = dim_(1)
            EjeY = dim_(2)
            EjeZ = dim_(3)
            EjeV = dim_(4)
            EjeW = dim_(5)
            EjeD = dim_(6)
            InverseK
        Next

    EndIf

    ' Guarda posicion de llegada como nueva posicion "vieja"
    Xold = EjeX
    Yold = EjeY
    Zold = EjeZ
    Vold = EjeV
    Wold = EjeW
    Dold = EjeD

    InverseK   ' Refresca el dibujo con la posicion final exacta
