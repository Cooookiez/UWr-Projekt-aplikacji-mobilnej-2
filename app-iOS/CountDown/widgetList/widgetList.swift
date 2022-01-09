//
//  widgetList.swift
//  widgetList
//
//  Created by Krzysztof Kukiz on 29/11/2021.
//

import WidgetKit
import SwiftUI

struct widgetListEntryView : View {
    

//    @ViewBuilder
//    var body: some View {
//        switch family {
//        case .systemMedium:
//            mediumView(events: entry.events)
//        case .systemLarge:
//        default:
//            fatalError()
//        }
////            Text(entry.date, style: .time)
//    }
    
    @Environment(\.widgetFamily) var family
    func getMaxItems() -> Int {
        
        var maxItems: Int = 0;
        switch family {
            case .systemMedium:
                maxItems = 5;
                break;
            case .systemLarge:
                maxItems = 13;
                break;
            default:
                fatalError();
                break;
        }
        return maxItems
    }
    var entry: Provider.Entry
    @EnvironmentObject var listEventModel: ListEventModel
    var body: some View {
        let calendar = Calendar.current
        let currentDate = Date()
        let maxItems = getMaxItems() <= entry.events.count ? getMaxItems() : entry.events.count;
        let textSize: CGFloat = 10;
        let textPadding: CGFloat = -0.5;
        VStack(alignment: .leading) {
            ForEach(0..<maxItems) { i in
                let eventItems = entry.events[i]
                let date1 = calendar.startOfDay(for: currentDate)
                let date2 = calendar.startOfDay(for: eventItems.date)
                let leftComponents = calendar.dateComponents([.day], from: date1, to: date2)
                let dayLeft = leftComponents.day ?? -1
                HStack(alignment: .top) {
                    Text("\(eventItems.name)")
                        .multilineTextAlignment(.leading)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .lineLimit(1)
                        .font(.system(size: textSize))
                        .foregroundColor(
                            dayLeft >= 0 ? Color(UIColor.label) : Color(UIColor.tertiaryLabel)
                        )
                    Text("\(dayLeft) " + "Days")
                        .multilineTextAlignment(.trailing)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .trailing
                        )
                        .lineLimit(1)
                        .fixedSize(
                            horizontal: true,
                            vertical: false
                        )
                        .font(.system(size: textSize))
                        .foregroundColor(
                            dayLeft >= 0 ? Color(UIColor.label) : Color(UIColor.tertiaryLabel)
                        )
                }
                if (i < maxItems-1) {
                    Divider()
                        .padding(.vertical, textPadding)
                }
            }
            .padding(.vertical, 0.2)
            .padding(.horizontal, 30.0)
            .frame(
                minWidth: 0,
                maxWidth: .infinity
            )
        }
        .padding(.vertical, 3.0)
        .frame(
            minHeight: 0,
            maxHeight: .infinity
        )
    }
}

@main
struct widgetList: Widget {
    let kind: String = "widgetList"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            widgetListEntryView(entry: entry)
        }
        .configurationDisplayName("CountDown Widget")
        .description("List your item and show how many days to the end")
        .supportedFamilies([
            .systemMedium,
            .systemLarge
        ])
    }
}

struct widgetList_Previews: PreviewProvider {
    static var previews: some View {
        widgetListEntryView(entry: ListEntry.mockListEntry())
            .previewDevice("iPhone 13 mini")
            .environment(\.sizeCategory, .medium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        widgetListEntryView(entry: ListEntry.mockListEntry())
            .previewDevice("iPhone 13")
            .environment(\.sizeCategory, .medium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        widgetListEntryView(entry: ListEntry.mockListEntry())
            .previewDevice("iPhone 13 Pro")
            .environment(\.sizeCategory, .medium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        widgetListEntryView(entry: ListEntry.mockListEntry())
            .previewDevice("iPhone 13 Pro Max")
            .environment(\.sizeCategory, .medium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        widgetListEntryView(entry: ListEntry.mockListEntry())
            .previewDevice("iPhone 13 Pro Max")
            .environment(\.sizeCategory, .medium)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
