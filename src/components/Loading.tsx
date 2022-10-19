import React from 'react'

export function Loading() {
  return (
    <div className="fixed left-0 top-0 bg-transparent w-full h-full flex justify-center items-center">
      <div className="text-2xl text-green-500">Loading...</div>
      <div className="absolute left-0 top-0 blur w-full h-full"></div>
    </div>
  )
}
