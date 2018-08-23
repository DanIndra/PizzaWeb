using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ShoppingCart
/// </summary>
///
public class ShoppingCart
{
    private List<CartItem> _Items;

    public ShoppingCart()
    {
        if (_Items == null) {
            _Items = new List<CartItem>();
        }
    }
    public List<CartItem> Items
    {
        get { return _Items; }
    }

    public decimal TotalValue{
        get
        {
            decimal functionReturnValue = default(decimal);
            foreach (CartItem item in _Items)
            {
                functionReturnValue += item.SubTotal;
            }
            return functionReturnValue;
        }
        }
    private decimal _DeliveryCharge = 3.5M;
    public decimal DeliveryCharge
    {
        get { return _DeliveryCharge; }
        set { _DeliveryCharge = value; }
    }

    private int ItemIndex(int MenuItemID, string ItemSize)
    {
        int index = 0;
        foreach (CartItem item in _Items)
        {
            if (item.MenuItemID == MenuItemID && item.ItemSize == ItemSize)
            {
                return index;
            }
            index += 1;
        }
        return -1;
        }
    public void Insert(int MenuItemID, string MenuItemType, string ItemSize, int Quantity, decimal ItemPrice)
    {
        int idx = ItemIndex(MenuItemID, ItemSize);
        if (idx == -1)
        {
            CartItem NewItem = new CartItem();
            NewItem.MenuItemID = MenuItemID;
            NewItem.MenuItemType = MenuItemType;
            NewItem.ItemSize = ItemSize;
            NewItem.ItemPrice = ItemPrice;
            NewItem.Quantity = Quantity;
            _Items.Add(NewItem);
        }
        else
        {
            _Items[idx].Quantity += 1;
        }
    }
    public void Update(int MenuItemID, string ItemSize, int Quantity)
    {
        int idx = ItemIndex(MenuItemID, ItemSize);
        if (idx != -1)
        {
            _Items[idx].Quantity = Quantity;
        }
    }
    public void Delete(int MenuItemID, string ItemSize)
    {
        int idx = ItemIndex(MenuItemID, ItemSize);
        if (idx != -1)
        {
            _Items.RemoveAt(idx);
        }
    }

    
    
}