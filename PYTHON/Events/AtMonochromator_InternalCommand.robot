*** Settings ***
Documentation    AtMonochromator_InternalCommand sender/logger tests.
Force Tags    python    Checking if skipped: atMonochromator
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 253 46 121 194 43 221 198 88 41 223 50 114 149 156 46 177 27 12 118 48 0 255 189 52 46 57 133 171 188 158 156 223 248 195 114 244 83 78 218 185 82 210 117 215 120 172 48 92 209 52 241 107 128 133 230 162 214 111 64 125 222 181 45 201 180 241 51 65 164 159 228 104 221 20 147 55 205 123 217 57 77 104 12 178 22 3 103 71 53 246 125 123 255 214 76 71 72 109 179 44 91 186 71 83 156 109 126 98 200 32 10 144 163 114 186 16 69 65 114 19 38 97 8 174 139 149 119 96 71 44 161 98 148 109 178 64 92 114 75 194 221 191 134 72 170 96 216 218 147 128 164 232 51 126 183 124 200 88 14 80 108 201 129 126 23 239 22 188 106 128 150 8 135 85 109 172 149 76 189 5 69 222 180 173 116 230 221 186 200 49 3 90 252 40 187 13 159 61 194 130 173 251 248 178 18 255 98 60 241 188 33 200 126 25 110 19 212 173 96 151 54 21 49 91 90 135 245 137 159 194 114 209 58 212 39 116 132 186 38 136 64 95 143 77 223 92 185 15 202 198 43 72 16 199 2 218 61 181 215 77 211 211 130 11 156 232 228 98 25 129 86 15 9 52 138 122 23 17 65 200 62 184 193 166 151 201 10 175 88 246 64 35 42 81 52 127 238 178 63 108 224 228 169 141 66 6 134 20 71 63 155 66 48 67 51 65 133 120 19 188 145 184 197 23 148 252 184 96 16 31 140 228 31 136 225 16 55 147 143 34 153 135 245 183 47 136 46 178 76 205 232 76 165 225 69 7 202 215 202 92 154 183 206 86 19 180 172 148 13 214 66 164 155 62 168 250 2 109 209 160 163 118 254 187 211 154 7 195 107 200 53 248 101 23 87 171 246 221 178 231 186 157 18 80 182 183 3 106 55 2 110 136 183 39 73 20 219 170 89 221 209 121 53 226 236 176 60 40 154 208 4 75 181 91 249 171 227 49 189 50 117 181 208 0 231 240 168 116 98 238 57 209 245 26 209 32 202 89 56 157 207 102 236 202 166 23 218 52 225 89 106 250 252 66 90 125 152 174 158 153 213 236 107 119 54 229 148 240 116 12 219 112 163 93 196 163 17 54 64 172 42 89 191 78 240 182 28 29 77 243 27 248 18 206 21 7 181 151 69 0 213 216 75 229 130 100 236 72 211 17 48 45 180 30 20 74 8 233 129 2 12 253 124 128 22 180 210 119 157 189 180 138 65 170 40 56 211 250 73 43 39 40 181 220 238 46 230 21 187 82 226 10 213 130 249 140 81 29 181 140 221 219 152 135 27 137 210 60 250 133 39 64 117 61 204 140 172 252 141 159 5 131 250 5 76 233 71 146 180 60 252 110 51 209 213 151 89 84 175 197 69 229 25 139 113 149 106 71 214 72 242 221 216 17 131 253 244 84 29 208 203 105 47 72 237 144 144 204 217 28 210 165 148 132 192 111 143 16 247 51 242 229 44 79 192 219 41 88 78 65 197 186 149 29 165 20 88 153 67 187 42 17 182 105 228 100 98 36 27 72 167 67 167 200 181 69 143 98 82 5 25 45 107 82 109 18 153 6 159 155 85 143 130 193 61 68 48 84 79 117 130 85 1 116 60 61 16 249 255 27 79 168 29 26 141 166 53 16 252 71 0 132 22 45 7 51 181 223 211 108 1 189 136 82 81 2 65 139 123 9 136 67 113 158 168 197 65 4 107 43 52 30 104 46 54 42 195 198 226 207 87 93 224 185 250 29 204 22 137 128 222 54 253 92 202 228 137 245 194 134 171 196 150 136 59 232 36 169 204 196 163 116 61 242 204 231 4 214 82 236 26 140 88 36 20 110 239 158 144 15 184 216 199 67 215 95 222 35 109 46 174 50 30 173 166 99 155 239 116 95 217 215 174 83 125 152 208 215 161 204 189 49 59 113 210 139 27 64 121 127 193 101 47 80 9 77 240 159 134 98 79 32 19 215 51 228 190 50 11 159 147 158 131 154 248 120 198 15 25 12 121 146 245 221 109 197 189 3 174 4 31 28 145 90 17 43 242 9 193 215 96 218 27 166 163 214 141 200 217 202 200 130 205 3 42 121 173 73 86 212 109 141 44 76 162 103 161 185 240 206 176 241 73 110 152 233 5 196 108 235 76 38 191 248 21 190 61 51 110 233 94 163 242 176 245 233 129 207 38 247 60 183 55 66 27 32 131 44 160 42 63 107 213 77 114 111 182 98 67 75 1729347476
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
