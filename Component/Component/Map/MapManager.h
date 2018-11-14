//
//  MapManager.h
//  ufo
//
//  Created by yuqing huang on 15/12/2017.
//  Copyright © 2017 Justek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol MappableItem <MKAnnotation>
@property (nonatomic, readonly, copy) NSString * _Nonnull title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@end

@interface ClusterableItemAnnotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) id <MappableItem> _Nonnull item;

- (nonnull instancetype)initWithItem:(id <MappableItem> _Nonnull )item;
@end

@interface ClusterAnnotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSArray<id <MappableItem>> * _Nonnull items;
@property (nonatomic, strong) id <MappableItem> _Nonnull firstItem;

- (nonnull instancetype)initWithItems:(NSArray<MappableItem> * _Nonnull)items;
@end

@interface ClusterAnnotationView : MKAnnotationView
- (nonnull instancetype)initWithAnnotation:(id <MKAnnotation> _Nullable)annotation reuseIdentifier:(NSString * _Nullable)reuseIdentifier ;
@end

@interface MapManager : NSObject
@property (nonatomic, copy) void(^ _Nullable clusterItemSelectionHandler)(id <MappableItem> _Nonnull);

- (nonnull instancetype)initWithMapView:(MKMapView * _Nonnull)mapView;
- (void)setItems:(NSArray * _Nonnull)items;
@end
