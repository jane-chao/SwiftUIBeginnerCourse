//
//  FoodForm.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/11/22.
//

import SwiftUI

extension FoodListView {
    struct FoodForm: View {
        @Environment(\.dismiss) private var dismiss
        @FocusState private var field: MyField?
        @State var food: Food
        var onSubmit: (Food) -> Void
        
        private var isNotValid: Bool { food.name.isEmpty || food.image.count > 2 }
        
        private var invalidMessage: String? {
            if food.name.isEmpty { return "請輸入名稱" }
            if food.image.count > 2 { return "圖示字數過多" }
            return .none
        }
        
        var body: some View {
            NavigationStack {
                VStack {
                    titleBar
                    
                    formView
                    
                    saveButton
                }
                .background(.groupBg)
                .multilineTextAlignment(.trailing)
                .font(.title3)
                .scrollDismissesKeyboard(.interactively)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(action: goPreviousField) { Image(systemName: "chevron.up") }
                        Button(action: goNextField) { Image(systemName: "chevron.down") }
                    }
                }
            }
        }
    }
}

// MARK: Subviews
private extension FoodListView.FoodForm {
    var titleBar: some View {
        HStack {
            Label("編輯食物資訊", systemImage: "pencil")
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "xmark.circle.fill")
                .font(.largeTitle.bold())
                .foregroundColor(.secondary)
                .onTapGesture { dismiss() }
        }.padding([.horizontal, .top])
    }

    var formView: some View {
        Form {
            LabeledContent("名稱") {
                TextField("必填", text: $food.name)
                    .focused($field, equals: .title)
            }
            
            LabeledContent("圖示") {
                TextField("最多輸入 2 個字元", text: $food.image)
                    .focused($field, equals: .image)
            }
            
            buildNumberField(title: "熱量", value: $food.calorie, field: .calories, suffix: "大卡")
            
            buildNumberField(title: "蛋白質", value: $food.protein, field: .protein)
            
            buildNumberField(title: "脂肪", value: $food.fat, field: .fat)
            
            buildNumberField(title: "碳水", value: $food.carb, field: .carb)
        }.padding(.top, -16)
    }
    
    var saveButton: some View {
        Button {
            dismiss()
            onSubmit(food)
        } label: {
            Text(invalidMessage ?? "儲存")
                .bold()
                .frame(maxWidth: .infinity)
        }
        .mainButtonStyle()
        .padding()
        .disabled(isNotValid)
    }
    
    func buildNumberField(title: String, value: Binding<Double>, field: MyField, suffix: String = "g") -> some View {
        LabeledContent(title) {
            HStack {
                TextField("", value: value, format: .number.precision(.fractionLength(1)))
                    .focused($field, equals: field)
                    .keyboardType(.decimalPad)
                Text(suffix)
            }
        }
    }
}


// MARK: Focus Handling
private extension FoodListView.FoodForm {
    func goPreviousField() {
        guard let rawValue = field?.rawValue else { return }
        field = .init(rawValue: rawValue - 1)
    }
    
    func goNextField() {
        guard let rawValue = field?.rawValue else { return }
        field = .init(rawValue: rawValue + 1)
    }
}

private enum MyField: Int {
    case title, image, calories, protein, fat, carb
}

private extension TextField where Label == Text {
    func focused(_ field: FocusState<MyField?>.Binding, equals this: MyField) -> some View {
        submitLabel(this == .carb ? .done : .next)
        .focused(field, equals: this)
        .onSubmit { field.wrappedValue = .init(rawValue: this.rawValue + 1) }
    }
}

// MARK: Preview
struct FoodForm_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView.FoodForm(food: Food.examples.first!) { _ in }
    }
}
