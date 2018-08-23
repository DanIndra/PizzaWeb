using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class StoredCart
{
    public StoredCart()
    {
    }
    private static ShoppingCart FetchCart()
    {
        ShoppingCart cart = (ShoppingCart)HttpContext.Current.Session["Cart"];

        if (cart == null)
        {
            cart = new ShoppingCart();
            HttpContext.Current.Session["Cart"] = cart;
        }
        return cart;
    }
    public static ShoppingCart Read()
    {
        return FetchCart();
    }
    public static List<CartItem> ReadItems()
    {
        ShoppingCart cart = StoredCart.FetchCart();
        return cart.Items;
    }
    public static void Update(decimal DeliveryCharge)
    {
        ShoppingCart cart = FetchCart();
        cart.DeliveryCharge = DeliveryCharge;
    }
    public static void UpdateItem(int MenuItemID, string ItemSize, int Quantity)
    {
        ShoppingCart cart = StoredCart.FetchCart();
        cart.Update(MenuItemID, ItemSize, Quantity);
    }

    public static void DeleteItem(int MenuItemID, string ItemSize)
    {
        ShoppingCart cart = StoredCart.FetchCart();
        cart.Delete(MenuItemID, ItemSize);
    }
    public static void InsertItem(int MenuItemID, string MenuItemType, string ItemSize, int Quantity,
     decimal ItemPrice)
    {
        ShoppingCart cart = StoredCart.FetchCart();
        cart.Insert(MenuItemID, MenuItemType, ItemSize, Quantity, ItemPrice);
    }

}