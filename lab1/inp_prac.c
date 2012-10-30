// Borland C++ - (C) Copyright 1991 by Borland International
/* DCOPY.CPP -- Example from Getting Started */
/* DCOPY source-file destination-file                           *
  * copies existing source -file to destination-file         *
  * If lat ter exis ts, it i s ov erwr itte n ; if it d oes not *
  * ex ist, DCO PY w ill crea te i t if pos s ible                    *
  */
#incl ude <ios trea m.h>
#incl ude <pro cess .h>         / / fo r ex it()
#incl ude <fst ream .h>         / / fo r if stre a m, of stre am
main( int argc , ch ar* argv []) // acce s s com mand -lin e ar gume nts
{
     ch ar c h;
     if (ar gc ! = 3)          // tes t nu mber of ar gume nts
     {
         cer r << "US AGE: dco py f ile1 fil e 2\n";
         exi t(-1 );
     }
     if stre am s ourc e;      // dec lare inp u t and out put stre ams
     of stre am d est;
     so urce .ope n(ar gv[1 ],io s::n ocre ate) ; // s ourc e fi le m ust be t here
     if (!s ourc e)
     {
         cer r << "Ca nnot ope n so urce fil e " << arg v[1] <<
                 " for inpu t\n" ;
         exi t(-1 );
     }
     de st.o pen( argv [2]) ;     // d est file will be c reat ed i f no t fo und
                         // o r cl eare d/ov erwr itte n if fou nd
     if (!d est)
     {
         cer r << "Ca nnot ope n de stin atio n file " < < ar gv[2 ] <<
                " f or o utpu t\n" ;
         exi t(-1 );
     }
     wh ile (des t && sou rce. get( ch)) des t .put( ch);
     co ut < < "D COPY com plet ed\n ";
     so urce .clo se() ;           // clos e bo t h str eams
     de st.c lose ();
} 
