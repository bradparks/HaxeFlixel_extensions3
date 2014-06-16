#ifndef IN_APP_PURCHASE_H
#define IN_APP_PURCHASE_H

namespace iap 
{	
    extern "C"
    {	
        void initInAppPurchase();
        void restorePurchases();
        bool canPurchase();
        void purchaseProduct(const char* productID);
		void requestProductData(const char *productID);
		void finishTransactionManually(const char *transactionID);
		bool getManualTransactionMode();
		void setManualTransactionMode(bool val);
        void releaseInAppPurchase();
    }
}

#endif
