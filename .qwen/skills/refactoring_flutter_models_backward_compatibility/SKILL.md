---
name: refactoring_flutter_models_backward_compatibility
description: Refactoring Flutter data models to align with backend schemas while keeping UI/view backward compatibility via class inheritance and extensions.
source: auto-skill
extracted_at: '2026-07-13T03:03:38.348Z'
---

# Refactoring Flutter Models with Backward Compatibility

When migrating front-end data models to align with backend schemas (e.g., matching prisma schemas or API specifications), renaming fields or classes can lead to cascading compilation failures throughout view and UI components. To complete this safely and autonomously:

## The Challenge
Directly updating models can break:
1. Dummy/mock data declarations that rely on original constructors.
2. Property accessors in UI views and widgets.
3. Collection types used in controllers and state management.

## The Approach: Hybrid Models & Extension Compatibility
Instead of choosing between a massive breaking refactor of the views or a non-standard model schema:
1. **Define the Standard/New Classes**: Declare the clean backend-aligned models (e.g., `User`, `Book`, `Category`) exactly as specified in the schema.
2. **Inherit for Legacy Compatibility**: Keep or declare legacy classes (e.g., `UserModel`, `BookModel`, `CategoryModel`) as subclasses of the new classes.
3. **Map Constructors and Defaults**: Implement constructors in the compatibility subclasses that map old properties to new ones and provide default values for any new mandatory fields not present in dummy data.
4. **Use Extension Getters**: Write Dart extensions on the new classes to expose legacy getters (e.g. `String get imagePath => coverImage`) so that any variable typed as the base class can still be queried by views using legacy field names.
5. **Add Imports in Views**: Ensure view files that reference legacy fields on instances typed as the new base class import the model file containing the extension.
