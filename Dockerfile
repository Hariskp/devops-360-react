# ใช้ Node.js เวอร์ชันเบาและรองรับ ARM (สำหรับ Mac M1)
FROM node:20-alpine

# กำหนด Working Directory
WORKDIR /app

# คัดลอกไฟล์ package.json และ package-lock.json ก่อน
COPY package.json package-lock.json ./

# ติดตั้ง Dependencies
RUN npm install

# คัดลอกโค้ดทั้งหมดไปยัง Container
COPY . .

# สร้างไฟล์ build สำหรับ Production
RUN npm run build

# ใช้ Nginx เป็น Web Server
FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html

# เปิดพอร์ต 80
EXPOSE 80

# รันเซิร์ฟเวอร์
CMD ["nginx", "-g", "daemon off;"]
