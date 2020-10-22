//
//  ImageSearch_SwiftUIWidgetExt.swift
//  ImageSearch-SwiftUIWidgetExt
//
//  Created by Jinwoo Kim on 10/22/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> FavoritesEntry {
        FavoritesEntry(
            date: Date(),
            configuration: ConfigurationIntent(),
            favorites: [.getSampleData(), .getSampleData()]
        )
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (FavoritesEntry) -> ()) {
        let entry = FavoritesEntry(
            date: Date(),
            configuration: configuration,
            favorites: [.getSampleData()]
        )
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [FavoritesEntry] = [
            .init(date: Date(),
                  configuration: configuration,
                  favorites: FavoritesModel.shared.nonPublisherFavorites
            )
        ]
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct FavoritesEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let favorites: [ResultData]
}

struct ImageSearch_SwiftUIWidgetExtEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WidgetView(favorites: entry.favorites)
    }
}

@main
struct ImageSearch_SwiftUIWidgetExt: Widget {
    let kind: String = "ImageSearch_SwiftUIWidgetExt"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ImageSearch_SwiftUIWidgetExtEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

//struct ImageSearch_SwiftUIWidgetExt_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageSearch_SwiftUIWidgetExtEntryView(entry: FavoritesEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
