//
//  MapManager.m
//  ufo
//
//  Created by yuqing huang on 15/12/2017.
//  Copyright © 2017 Justek. All rights reserved.
//

#import "MapManager.h"

#define Map_Graphics_Distance        15
#define One_Latitude_Distance        111200
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

@interface ItemEntity :NSObject<MappableItem>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) CLLocation *location;
@end

@implementation ItemEntity

- (CLLocationCoordinate2D)coordinate {
    return self.location.coordinate;
}

@end

@implementation ClusterableItemAnnotation

- (nonnull instancetype)initWithItem:(id <MappableItem> _Nonnull )item
{
    self = [super init];
    if (self) {
        _item = item;
        _coordinate = item.coordinate;
    }
    return self;
}

@end

@implementation ClusterAnnotation

- (nonnull instancetype)initWithItems:(NSArray<MappableItem> *)items
{
    self = [super init];
    if (self) {
        _items = items;
        _firstItem = [items firstObject];
        _coordinate = _firstItem.coordinate;
    }
    return self;
}
@end

@implementation ClusterAnnotationView

- (nonnull instancetype)initWithAnnotation:(id <MKAnnotation> _Nullable)annotation reuseIdentifier:(NSString * _Nullable)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

@end

@interface MapManager ()<MKMapViewDelegate>
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, strong) id<MKMapViewDelegate> mapViewDelegate;
@end

@implementation MapManager
- (instancetype)initWithMapView:(MKMapView *)mapView
{
    self = [super init];
    if (self) {
        self.mapView = mapView;
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    if (self.mapView.annotations.count > 0) {
        NSMutableArray *toRemove = [[NSMutableArray alloc] initWithArray:self.mapView.annotations];
        
        for (id annotation in self.mapView.annotations) {
            if (annotation == self.mapView.userLocation) {
                [toRemove removeObject:annotation];
                break;
            }
        }
        [self.mapView removeAnnotations:toRemove];
    }
    
    if (items.count > 0) {
        NSMutableArray *muItems = [[NSMutableArray alloc]initWithArray:items];
        for (NSInteger i = muItems.count-1; i >=0; i--) {
            ItemEntity *item1 = muItems[i];
            MKMapPoint p = MKMapPointForCoordinate(item1.location.coordinate);
            if (MKMapRectContainsPoint(self.mapView.visibleMapRect, p)) {
                ItemEntity *item2 = nil;
                NSMutableArray *annotationArray = [[NSMutableArray alloc] initWithArray:@[item1]];
                
                for (NSInteger j = i-1; j>=0; j--) {
                    item2 = muItems[j];
                    long long mapDistance = [item1.location distanceFromLocation:item2.location];
                    CGFloat graphicsLength = mapDistance * SCREEN_WIDTH / (self.mapView.region.span.latitudeDelta * One_Latitude_Distance);
                    if (graphicsLength <= Map_Graphics_Distance) {
                        
                        [annotationArray addObject:item2];
                        [muItems removeObject:item2];
                        i--;
                    }
                }
                
                if (annotationArray.count > 1) {
                    ClusterAnnotation *repeatItem = [[ClusterAnnotation alloc] initWithItems:[annotationArray copy]];
                    [self.mapView addAnnotation:repeatItem];
                } else {
                    ClusterableItemAnnotation *item = [[ClusterableItemAnnotation alloc] initWithItem:item1];
                    [self.mapView addAnnotation:item];
                }
            }
        }
        
    }
    
}

@end
