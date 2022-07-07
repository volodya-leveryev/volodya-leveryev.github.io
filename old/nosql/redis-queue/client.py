import redis


def handler(message):
    print("New message recieved:", message['data'].decode('utf-8'))


r = redis.Redis('10.14.156.254')
p = r.pubsub()
p.subscribe(**{'chat': handler})
thread = p.run_in_thread(sleep_time=0.5)  # Создание потока для получения сообщий

print("Press Ctrl+C to stop")
while True:
    try:
        new_message = input()
        r.publish('chat', new_message)
    except KeyboardInterrupt:
        break
print("Stopped")
thread.stop()
