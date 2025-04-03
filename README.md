# **Feature Flagging Framework**  

A lightweight, extensible **Feature Flagging Framework** for Salesforce that allows controlled rollouts, gradual deployments, and easy management of feature toggles using **Custom Metadata** instead of hardcoded settings.  

## **How To Use?**  
1️⃣ **Create a New Feature Flag** - Create a record in Feature_Flag__mdt for your feature.  
2️⃣ **Call Framework** - Check feature status using below function call.  
```java
Feature.isActive(FeatureName);
```

## **Why This Framework?**  
Managing feature rollouts in Salesforce often involves **custom labels** or **custom settings**, requiring manual updates and cluttering the org with unnecessary entries. This framework provides:  

✔ **Scalability** – Add new feature types without modifying core logic  
✔ **Extensibility** – Define custom rollout strategies  
✔ **Performance** – Cached evaluations for better efficiency  
✔ **Maintainability** – Follows **SOLID principles** for clean and structured code  

---

## **How It Works**  

1️⃣ **Feature Flags as Metadata** – Define features in Custom Metadata instead of hardcoded settings.  
2️⃣ **Factory Pattern for Rollout Strategies** – Each flag type has its own class, making it easy to extend.  
3️⃣ **Supports Multiple Rollout Strategies** – Enabled/Disabled, Custom Permission, and more planned.  
4️⃣ **Separation of Concerns** – Keeps flag logic separate from business logic. 
4️⃣ **Caching Mechanism** – Caches evaluated feature flag results for faster access minimizing server round trips.   

### **Current Rollout Strategies**  
✅ **Enabled/Disabled** – Simple ON/OFF feature flag  
✅ **Custom Permission-Based** – Checks if a user has a permission to enable a feature  
✅ **(Planned) Profile-Based, Role-Based, Org-Based Rollouts and many more**  

### **Planned Features**  
💡**Time based rollout**  
💡**Custom Feature Type Support**  
💡**Interactive Ui for admin**   
💡**Multi feature support**  
