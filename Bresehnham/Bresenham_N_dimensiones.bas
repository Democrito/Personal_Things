
' Este es un ejemplo general de algoritmo de Bresenham para N dimensiones. Puedes declarar tantas como necesites.
' ---------------------------------------------------------------------------------------------------------------


#Define N 6     ' N = Número de dimensiones, en este caso son 6.

Dim As Integer d(N), ad(N), incr(N), dx2(N), errr(N)
Dim As Integer dim_(N), old_(N), new_(N)
Dim As Integer i, k, primary

Do
    Input "Dim1: ", new_(1) : Input "Dim2: ", new_(2)   ' Hay que declarar tantos "input" y "new_()" como dimensiones necesites.
    Input "Dim3: ", new_(3) : Input "Dim4: ", new_(4)   ' Puedes simplificarlo aún más con un bucle "for-next" para esas n-dimensiones como entrada. 
    Input "Dim5: ", new_(5) : Input "Dim6: ", new_(6)

    ' --- Deltas, signos y magnitudes ---
    For i = 1 To N
        d(i)    = new_(i) - old_(i)
        incr(i) = IIf(d(i) < 0, -1, 1)
        ad(i)   = Abs(d(i))
        dx2(i)  = ad(i) Shl 1
    Next

    ' --- Eje director: primero con mayor |d|  (mismo desempate que el original) ---
    primary = 1
    For i = 2 To N
        If ad(i) > ad(primary) Then primary = i
    Next

    ' --- errores iniciales sólo de los ejes secundarios ---
    For i = 1 To N
        If i <> primary Then errr(i) = dx2(i) - ad(primary)
    Next
    
    Print dim_(1); " "; dim_(2); " "; dim_(3); " "; dim_(4); " "; dim_(5); " "; dim_(6)  ' Se imprime tantos "dim_()" como dimensiones hayamos declarado arriba.

    ' --- Recorrido ---
    For k = 1 To ad(primary)
        For i = 1 To N
            If i <> primary Then
                If errr(i) > 0 Then
                    dim_(i) += incr(i)
                    errr(i)  -= dx2(primary)
                End If
                errr(i) += dx2(i)
            End If
        Next
        dim_(primary) += incr(primary)
        Print dim_(1); " "; dim_(2); " "; dim_(3); " "; dim_(4); " "; dim_(5); " "; dim_(6)  ' Se imprime tantos "dim_()" como dimensiones hayamos declarado arriba.
    Next

    For i = 1 To N
        old_(i) = new_(i)
    Next
Loop

End