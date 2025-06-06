//+------------------------------------------------------------------+
//|                                                       RSI_ML.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#import "RFML.dll"
   double PredictTrade(double ema, double adx, double poc, double vah, double val, double volume, double atr);
#import

#import "AMM.dll"
   double getRiskAllocation(double ema, double adx, double poc, double vah, double val, double volume, double atr);
#import

input int MagicNumber = 777;
input double BaseLotSize = 0.1;
input double MinMultiplier = 0.5;
input double MaxMultiplier = 2.0;
input int RSIPeriod = 14;
input double RSIBuyLevel = 30.0;
input double RSISellLevel = 70.0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {

 // Evitiamo più ordini aperti
   if (OrdersTotal() > 0) return;

   // Calcolo RSI e condizioni base
   double rsi = iRSI(NULL, 0, RSIPeriod, PRICE_CLOSE, 0);
   double price = Bid;

   // Calcolo indicatori richiesti da ML (mock semplificati per esempio)
   double ema = iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, 0);
   double adx = iADX(NULL, 0, 14, PRICE_CLOSE, MODE_MAIN, 0);
   double poc = iCustom(NULL, 0, "VolumeProfile", 0, 0); // Placeholder
   double vah = iCustom(NULL, 0, "VolumeProfile", 1, 0);
   double val = iCustom(NULL, 0, "VolumeProfile", 2, 0);
   double volume = (double)Volume[0];
   double atr = iATR(NULL, 0, 14, 0);

   // Chiamate AI
   double prob = PredictTrade(ema, adx, poc, vah, val, volume, atr);
   double riskMult = getRiskAllocation(ema, adx, poc, vah, val, volume, atr);
   riskMult = MathMax(MinMultiplier, MathMin(MaxMultiplier, riskMult));

   double lotSize = NormalizeDouble(BaseLotSize * riskMult, 2);

   // Condizioni Buy/Sell
   if (rsi < RSIBuyLevel && prob > 0.7)
   {
      int ticket = OrderSend(Symbol(), OP_BUY, lotSize, Ask, 3, 0, 0, "Buy RSI + ML", MagicNumber, 0, clrGreen);
      if (ticket < 0) Print("Errore BUY: ", GetLastError());
   }
   else if (rsi > RSISellLevel && prob > 0.7)
   {
      int ticket = OrderSend(Symbol(), OP_SELL, lotSize, Bid, 3, 0, 0, "Sell RSI + ML", MagicNumber, 0, clrRed);
      if (ticket < 0) Print("Errore SELL: ", GetLastError());
   }
}
//+------------------------------------------------------------------+
