//+------------------------------------------------------------------+
//|                                                    atr_bands.mq4 |
//|                                         Copyright 2018, M Wilson |
//+------------------------------------------------------------------+
#property copyright " Copyright © 2018, M Wilson"
//----
#property indicator_chart_window
#property indicator_buffers 2
#include <stdlib.mqh>
//+------------------------------------------------------------------+
//| Common External variables                                        |
//+------------------------------------------------------------------+
extern double ATRPeriod=10;
extern double ATRMult=1;
extern int ATROffset=1;
extern int MidOffset=1;
extern int LineWidth=1;
extern color LineColor=clrRed;
//+------------------------------------------------------------------+
//| Special Convertion Functions                                     |
//+------------------------------------------------------------------+
int LastTradeTime;
double ExtHistoBuffer[];
double ExtHistoBuffer2[];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetLoopCount(int loops)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetIndexValue(int shift, double value)
  {
   ExtHistoBuffer[shift]=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetIndexValue2(int shift, double value)
  {
   ExtHistoBuffer2[shift]=value;
  }
//+------------------------------------------------------------------+
//| End                                                              |
//+------------------------------------------------------------------+
int init()
  {
   SetIndexStyle(0, DRAW_LINE, STYLE_SOLID,LineWidth,LineColor);
   SetIndexBuffer(0, ExtHistoBuffer);
   SetIndexStyle(1, DRAW_LINE, STYLE_SOLID,LineWidth,LineColor);
   SetIndexBuffer(1, ExtHistoBuffer2);
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
//+------------------------------------------------------------------+
//| Local variables                                                  |
//+------------------------------------------------------------------+
   int shift=0;
   double ma=0;
   double atr=0;
   double KU=0;
   double KL=0;
   SetLoopCount(0);
   // loop from first bar to current bar (with shift=0)
     for(shift=Bars-1;shift>=0 ;shift--)
     {
      ma=0.5*(iHigh(Symbol(),0,shift+MidOffset)+iLow(Symbol(),0,shift+MidOffset));
      atr=iATR(NULL, 0, ATRPeriod, shift+ATROffset)/2;
      KU=ma + ATRMult*atr;
      KL=ma - ATRMult*atr;
      SetIndexValue(shift, KU);
      SetIndexValue2(shift, KL);
     }
   return(0);
  }
//+------------------------------------------------------------------+