       SUBROUTINE EXAMPLEPF(NP1,NP2,NX,P1,P2,X,NC,F,C,DF,DC)

       INTEGER NP1,NP2,NX,NC
       DOUBLE PRECISION X(*),P1(*),F,C(*),DF(*),DC(*),F1,F2
       CHARACTER P2(*)

       F1 = X(1)**2 + X(2)**2
       F2 = X(1)**2*X(2) + X(1)*(1-X(2))       

       IF (P2(1) .EQ. '0') THEN
          F = F1
          DF(1) = 2*X(1)
          DF(2) = 2*X(2)
       ELSE
          F = F2
          DF(1) = 2*X(1)*X(2)+1
          DF(2) = X(1)**2 - X(1)
       ENDIF

C       F = F1*(1-P1(1)) + F2*P1(1)
C       DF(1) = 2*X(1)*(1-P1(1)) + (2*X(1)*X(2)+1)*P1(1)
C       DF(2) = 2*X(2)*(1-P1(1)) + (X(1)**2-X(1))*P1(1)
       NC = 0
       
       RETURN
       END
