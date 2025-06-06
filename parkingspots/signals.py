from django.db.models.signals import post_save
from django.dispatch import receiver
from parkingspots.models import ParkingRecord


# Quando um resgistro de vaga for feito no model ParkingRecord, 
# vai disparar um evento fazendo com que o campo is_occupied do model 
# Parkingspot seja True.
@receiver(post_save, sender=ParkingRecord)
def update_parking_spot_status(sender, instance, created, **kwargs):
    parking_spot = instance.parking_spot
    parking_spot.is_occupied = instance.exit_time is None
    parking_spot.save()

    