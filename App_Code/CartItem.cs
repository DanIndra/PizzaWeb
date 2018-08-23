using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ShoppingCart
/// </summary>
public class CartItem
{
    private int _MenuItemID;
    private string _MenuItemType;
    private string _ItemSize;
    private int _Quantity;
    private decimal _ItemPrice;
    //Creates a new, Empty cart item
    public CartItem()
    {
    }
    // Create a new cart item
    
    public CartItem(int MenuItemID, String MemuItemType, String ItemSize, int Quantity, decimal ItemPrice)
    {
        // initialize the private member variables with the supplied values
        _MenuItemID = MenuItemID;
        _MenuItemType = MenuItemType;
        _ItemSize = ItemSize;
        _Quantity = Quantity;
        _ItemPrice = ItemPrice;
    }
    public int MenuItemID
    {
        get { return _MenuItemID; }
        set { _MenuItemID = value; }
    }
    public string MenuItemType
    {
        get { return _MenuItemType; }
        set { _MenuItemType = value; }
    }
    public string ItemSize
    {
        get { return _ItemSize; }
        set { _ItemSize = value; }
    }
    public int Quantity
    {
        get { return _Quantity; }
        set { _Quantity = value; }
    }
    public decimal ItemPrice
    {
        get { return _ItemPrice; }
        set { _ItemPrice = value; }
    }
    public decimal SubTotal
    {
        get { return _Quantity * _ItemPrice; }
    }

}