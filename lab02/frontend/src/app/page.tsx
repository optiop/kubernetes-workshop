'use client';
import { useEffect, useState } from 'react';

export default function Home() {
  const [students, setStudents] = useState([
    {
      name: "Loading...",
      email: "Loading..."
    }
  ]);
  useEffect(() => {
      fetch("http://localhost:5000/", {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      }).then((res) => res.json())
        .then((students) => {
          if (Array.isArray(students.students)) {
            console.log(students);
            setStudents(students.students);
          }
        })
        .catch((error) => {
          console.log(error);
        });
  }, []);

  return (
    <div className="relative overflow-x-auto">
      <table className="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead className="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th scope="col" className="px-6 py-3">
              Student
            </th>
            <th scope="col" className="px-6 py-3">
              Email
            </th>
          </tr>
        </thead>
        <tbody>
          {students.map((student, index) => (
            <tr className="bg-white border-b dark:bg-gray-800 dark:border-gray-700" key={index}>
              <th
                scope="row"
                className="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white"
              >
                {student.name}
              </th>
              <td className="px-6 py-4">{student.email}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}